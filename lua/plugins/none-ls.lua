-- none ls wraps command line tools such as linter and formatter as an LSP for neovim to process
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")

    -- kubeconform validates every document of a (multi-doc) Kubernetes YAML file on save.
    -- It covers files with mixed kinds, which yamlls cannot match to one schema (see config/k8s-schema.lua).
    -- Core resources use the default schemas, everything else uses the datreeio CRDs-catalog.
    local kubeconform_cache = vim.fn.stdpath("cache") .. "/kubeconform"
    vim.fn.mkdir(kubeconform_cache, "p")
    local kubeconform = helpers.make_builtin({
      name = "kubeconform",
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      filetypes = { "yaml" },
      generator_opts = {
        command = "kubeconform",
        args = {
          "-output",
          "json",
          "-ignore-missing-schemas",
          "-cache",
          kubeconform_cache,
          "-schema-location",
          "default",
          "-schema-location",
          "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/"
            .. "{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json",
          "-",
        },
        to_stdin = true,
        format = "json",
        -- kubeconform exits with 1 when a resource is invalid, which is not a tool failure
        check_exit_code = { 0, 1 },
        runtime_condition = helpers.cache.by_bufnr(function(params)
          local lines = vim.api.nvim_buf_get_lines(params.bufnr, 0, -1, false)
          return vim.iter(lines):any(function(line)
            return line:match("^apiVersion:") ~= nil
          end)
        end),
        on_output = function(params)
          -- kubeconform reports no line numbers, so find the "kind:" line of the matching document
          local documents = {}
          local current
          for index, line in ipairs(vim.api.nvim_buf_get_lines(params.bufnr, 0, -1, false)) do
            if line:match("^%-%-%-") then
              current = nil
            elseif line:match("^kind:") then
              current = { row = index, kind = line:match("^kind:%s*(%S+)") }
              table.insert(documents, current)
            elseif current and not current.name and line:match("^  name:") then
              current.name = line:match("^  name:%s*(%S+)")
            end
          end

          local function row_for(resource)
            local fallback
            for _, document in ipairs(documents) do
              if document.kind == resource.kind then
                fallback = fallback or document.row
                if document.name == resource.name then
                  return document.row
                end
              end
            end
            return fallback or 1
          end

          local severities = helpers.diagnostics.severities
          local diagnostics = {}
          for _, resource in ipairs(params.output.resources or {}) do
            if resource.status == "statusInvalid" then
              for _, problem in ipairs(resource.validationErrors or { { path = "", msg = resource.msg } }) do
                table.insert(diagnostics, {
                  row = row_for(resource),
                  col = 1,
                  source = "kubeconform",
                  severity = severities.error,
                  message = string.format("%s %s: %s %s", resource.kind, resource.name, problem.path, problem.msg),
                })
              end
            elseif resource.status == "statusError" then
              table.insert(diagnostics, {
                row = row_for(resource),
                col = 1,
                source = "kubeconform",
                severity = severities.warning,
                message = string.format("%s %s: %s", resource.kind, resource.name, resource.msg),
              })
            end
          end
          return diagnostics
        end,
      },
      factory = helpers.generator_factory,
    })

    null_ls.setup({
      -- make sure these are installed in mason via mason install tool from lsp-config lua
      update_in_insert = false,
      sources = {
        ----------------
        -- formatting --
        ----------------
        null_ls.builtins.formatting.black.with({
          extra_args = {
            "--line-length=160",
            "--skip-string-normalization",
          },
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.markdownlint.with({
          extra_args = { "--max-line-length=120" },
        }),
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-width", "2", "--indent-type", "Spaces", "--column-width", "120" },
        }),
        null_ls.builtins.formatting.shfmt.with({
          filetypes = { "sh", "bash" },
          extra_args = { "-i", "2", "-ci" },
        }),
        -- null_ls.builtins.formatting.shellharden, -- needs cargo
        null_ls.builtins.formatting.opentofu_fmt, -- runs `tofu fmt`, never `terraform`
        -- same formatter as the pre-commit hook of lqt-configuration-store, reads .yamlfmt from the project root
        null_ls.builtins.formatting.yamlfmt,
        -- MD013:
        --   # Number of characters
        --   line_length: 80

        -----------------
        -- linter --
        -----------------
        null_ls.builtins.diagnostics.golangci_lint, -- uses golangci-lint from PATH (brew) and the repo config
        null_ls.builtins.diagnostics.hadolint,
        kubeconform,
        null_ls.builtins.diagnostics.markdownlint.with({
          extra_args = { "--max-line-length=120" },
        }),
        null_ls.builtins.diagnostics.yamllint.with({
          filetypes = { "yaml", "yml" }, -- remove helm here
          extra_args = {
            "-d",
            "{extends: default, rules: {"
              .. "document-start: disable, "
              .. "comments: {require-starting-space: true, ignore-shebangs: true, min-spaces-from-content: 1}, "
              .. "indentation: {spaces: 2, indent-sequences: consistent}, "
              .. "line-length: {max: 150}"
              .. "}}",
          },
        }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
