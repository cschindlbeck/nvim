return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- servers are enabled explicitly below with vim.lsp.enable
      automatic_enable = false,
    },
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "towolf/vim-helm",
    ft = "helm",
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- lazy = false,
    config = function()
      -- completion capabilities for all servers (blink.cmp)
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

      -- Bash
      vim.lsp.config.bashls = {
        filetypes = { "sh", "zsh", "bash" },
      }
      vim.lsp.enable("bashls")

      -- Docker
      vim.lsp.config.dockerls = {
        filetypes = { "dockerfile" },
      }
      vim.lsp.enable("dockerls")

      -- Docker Compose
      vim.lsp.config.docker_compose_language_service = {
        -- filetypes = { "yaml", "yml" },
      }
      vim.lsp.enable("docker_compose_language_service")

      -- Go
      vim.lsp.config.gopls = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          gopls = {
            completeUnimported = true,
            gofumpt = true,
            semanticTokens = true,
            staticcheck = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              inferTypeArgs = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      }
      vim.lsp.enable("gopls")

      -- Helm (using helm_ls)
      vim.lsp.config.helm_ls = {
        -- helm_ls needs the "serve" argument
        cmd = { "helm_ls", "serve" },
        -- helm-ls provides completions for Helm charts and Helmfile etc.
        filetypes = { "helm", "helmfile" },
        settings = {
          -- note the exact key: 'helm-ls'
          ["helm-ls"] = {
            -- point to your yaml-language-server executable if you want helm-ls to use it
            -- yamlls = {
            --   path = "yaml-language-server",
            --   enabled = true,
            --   enabledForFilesGlob = "*.{yaml,yml}",
            -- },
            -- optional useful defaults
            valuesFiles = {
              mainValuesFile = "values.yaml",
              additionalValuesFilesGlobPattern = "values*.yaml",
            },
            helmLint = { enabled = true },
          },
        },
      }
      vim.lsp.enable("helm_ls")

      -- JSON
      vim.lsp.enable("jsonls")

      -- Lua
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        settings = {
          Lua = {
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                max_line_length = "120",
              },
            },
          },
        },
      }
      vim.lsp.enable("lua_ls")

      -- Pyright
      vim.lsp.config.pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      }
      vim.lsp.enable("pyright")

      -- Opentofu
      -- tofu-ls issue #156 (semantic tokens CPU loop on heredocs) is fixed since v0.4.1,
      -- so the -req-concurrency workaround is removed.
      vim.lsp.config.tofu_ls = {
        cmd = { "tofu-ls", "serve" },
        filetypes = { "opentofu", "opentofu-vars", "terraform", "tf", "hcl" },
        root_markers = { ".terraform", ".terraform.lock.hcl", ".git" },
        -- Workaround: Neovim incremental sync assertion failure in vim/lsp/sync.lua
        -- tofu_ls uses incremental sync which triggers a bug in compute_end_range on delete.
        -- flags.allow_incremental_sync = false forces full document sync via the
        -- supported code path in _changetracking.lua:get_group().
        flags = {
          allow_incremental_sync = false,
        },
        settings = {
          terraform = {
            languageServer = {
              indexing = {
                ignorePaths = {
                  "**/.terraform",
                  "**/.terraform/**",
                },
                ignoreDirectoryNames = { ".terraform" },
              },
            },
          },
        },
      }
      vim.lsp.enable("tofu_ls")

      -- Yaml
      vim.lsp.config.yamlls = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml" },
        settings = {
          yaml = {
            validate = true,
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas({
              extra = {
                {
                  description = "Flux Tofu Controller CRDs",
                  fileMatch = { "tf-controller.crds.yaml" },
                  name = "tf-controller.crds.yaml",
                  url = "https://github.com/flux-iac/tofu-controller/releases/download/v0.15.1/tf-controller.crds.yaml",
                },
                {
                  description = "Flux Kustomize Controller CRDs",
                  fileMatch = { "kustomize-controller.crds.yaml" },
                  name = "kustomize-controller.crds.yaml",
                  url = "https://github.com/fluxcd/kustomize-controller/releases/"
                    .. "download/v1.7.2/kustomize-controller.crds.yaml",
                },
                {
                  description = "Flux Source Controller CRDs",
                  fileMatch = { "source-controller.crds.yaml" },
                  name = "source-controller.crds.yaml",
                  url = "https://github.com/fluxcd/source-controller/releases/"
                    .. "download/v1.7.3/source-controller.crds.yaml",
                },
              },
            }),
            format = {
              enabled = true,
              printWidth = 220, -- unrealistically high for now
            },
          },
        },
      }
      vim.lsp.enable("yamlls")

      -- Buffer-local keymaps, set when a server attaches.
      -- The rest comes from Neovim defaults: grr references, gri implementation, grn rename, gra code action,
      -- grt type definition, gO document symbols, K hover
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer_opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, buffer_opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buffer_opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buffer_opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buffer_opts)
        end,
      })

      -- Diagnostics
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, {})
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, {})
      -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})  -- set for open picker
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

      -- Autoformat
      -- If none-ls can format the buffer, only it formats. Otherwise all LSP clients with formatting may run.
      -- This avoids two clients (e.g. lua_ls and none-ls/stylua) formatting the same buffer.
      local format_filter = function(client)
        local null_ls_clients = vim.lsp.get_clients({ bufnr = 0, name = "null-ls", method = "textDocument/formatting" })
        if #null_ls_clients > 0 then
          return client.name == "null-ls"
        end
        return true
      end
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          local clients = vim.lsp.get_clients({ bufnr = args.buf })
          if #clients > 0 then
            -- Go: organize imports via gopls (synchronous, so the format below sees the result)
            local gopls = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })[1]
            if gopls then
              local params = vim.lsp.util.make_range_params(0, gopls.offset_encoding)
              params.context = { only = { "source.organizeImports" }, diagnostics = {} }
              local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1000)
              for _, response in pairs(result or {}) do
                for _, action in pairs(response.result or {}) do
                  if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, gopls.offset_encoding)
                  end
                end
              end
            end
            vim.lsp.buf.format({ async = false, bufnr = args.buf, filter = format_filter })
          end
        end,
      })
      local opts = {}
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true, filter = format_filter })
      end, opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "bashls",
        "black",
        "delve",
        "docker-compose-language-service",
        "dockerls",
        "gopls",
        "hadolint",
        "helm_ls",
        "isort",
        "lua-language-server",
        "lua_ls",
        "markdownlint",
        "tofu_ls",
        "pyright",
        "shellcheck",
        -- "shellharden", -- needs cargo
        "shfmt",
        "stylua",
        -- "terraformls", -- i migrate to opentofu
        "tflint",
        "tfsec",
        "yaml-language-server",
        "yamlfmt",
        "yamllint",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
