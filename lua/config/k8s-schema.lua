-- Assign a JSON schema to each Kubernetes YAML buffer, based on its apiVersion and kind.
-- yamlls cannot detect the kind by itself, so we add a per-buffer schema entry and push it to the server.
-- Core resources use yannh/kubernetes-json-schema.
-- Everything else (Flux, tofu-controller, ...) uses datreeio/CRDs-catalog.

local catalog_url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main"
local core_url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict"

-- API groups that belong to core Kubernetes (no group means the core v1 group).
-- Keep this list explicit: some *.k8s.io groups are CRDs (gateway.networking.k8s.io, snapshot.storage.k8s.io)
-- and their schemas exist only in the CRDs-catalog.
local core_groups = {
  ["apps"] = true,
  ["batch"] = true,
  ["autoscaling"] = true,
  ["policy"] = true,
  ["networking.k8s.io"] = true,
  ["rbac.authorization.k8s.io"] = true,
  ["storage.k8s.io"] = true,
  ["apiextensions.k8s.io"] = true,
  ["admissionregistration.k8s.io"] = true,
  ["scheduling.k8s.io"] = true,
  ["apiregistration.k8s.io"] = true,
  ["certificates.k8s.io"] = true,
  ["coordination.k8s.io"] = true,
  ["discovery.k8s.io"] = true,
  ["events.k8s.io"] = true,
  ["flowcontrol.apiserver.k8s.io"] = true,
  ["node.k8s.io"] = true,
  ["resource.k8s.io"] = true,
}

-- schema URL this module assigned, per client and buffer: { [client_id] = { [bufnr] = url } }
-- Keyed by client, so a restarted yamlls or a second yamlls (other root_dir) gets its own state.
local assigned = {}

-- Returns the schema URL if every document in the buffer has the same apiVersion and kind, otherwise nil.
-- yamlls matches schemas per file, so a multi-document file with mixed kinds would validate wrongly.
local function schema_url_for(bufnr)
  local seen = {}
  local count = 0
  local api_version, kind

  local function flush()
    if api_version and kind then
      local key = api_version .. "/" .. kind
      if not seen[key] then
        seen[key] = { api_version = api_version, kind = kind }
        count = count + 1
      end
    end
    api_version, kind = nil, nil
  end

  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    if line:match("^%-%-%-") then
      flush()
    else
      -- values can be quoted: apiVersion: "apps/v1"
      api_version = line:match([[^apiVersion:%s*["']?([%w%.%-/]+)]]) or api_version
      kind = line:match([[^kind:%s*["']?(%w+)]]) or kind
    end
  end
  flush()

  if count ~= 1 then
    return nil
  end

  local resource = select(2, next(seen))
  local group, version = resource.api_version:match("^(.+)/(.+)$")
  local kind_lower = resource.kind:lower()

  if not group then
    -- kubeconfig files (~/.kube/config) use apiVersion v1 too, but there is no schema for them
    if resource.kind == "Config" then
      return nil
    end
    return string.format("%s/%s-%s.json", core_url, kind_lower, resource.api_version)
  end
  if core_groups[group] then
    return string.format("%s/%s-%s-%s.json", core_url, kind_lower, group:match("^[^%.]+"), version)
  end
  -- kustomization.yaml is already covered by schemastore
  if group == "kustomize.config.k8s.io" then
    return nil
  end
  return string.format("%s/%s/%s_%s.json", catalog_url, group, kind_lower, version)
end

-- remove one buffer URI from the schema entry of a URL (several buffers can share the same URL)
local function remove_uri(schemas, url, uri)
  local uris = vim.tbl_filter(function(existing)
    return existing ~= uri
  end, schemas[url] or {})
  schemas[url] = #uris > 0 and uris or nil
end

local function assign_schema(client, bufnr)
  local url = schema_url_for(bufnr)
  local uri = vim.uri_from_bufnr(bufnr)
  local state = assigned[client.id] or {}
  local previous = state[bufnr]

  if previous == url then
    return
  end

  local schemas = client.settings.yaml.schemas
  if previous then
    remove_uri(schemas, previous, uri)
  end
  if url then
    schemas[url] = schemas[url] or {}
    table.insert(schemas[url], uri)
  end
  state[bufnr] = url
  assigned[client.id] = next(state) and state or nil
  client:notify("workspace/didChangeConfiguration", { settings = client.settings })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "yamlls" then
      return
    end
    assign_schema(client, args.buf)
  end,
})

-- Check the kind again on save. The clients are looked up on each save, so no autocmd holds an old client.
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf, name = "yamlls" })) do
      assign_schema(client, args.buf)
    end
  end,
})

-- LspDetach fires when the buffer is unloaded and when the client stops.
-- Remove the URI from the client that owns the buffer, and tell the server if it still runs.
vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    local client_id = args.data.client_id
    local url = assigned[client_id] and assigned[client_id][args.buf]
    if not url then
      return
    end
    assigned[client_id][args.buf] = nil
    if next(assigned[client_id]) == nil then
      assigned[client_id] = nil
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client and not client:is_stopped() then
      remove_uri(client.settings.yaml.schemas, url, vim.uri_from_bufnr(args.buf))
      client:notify("workspace/didChangeConfiguration", { settings = client.settings })
    end
  end,
})
