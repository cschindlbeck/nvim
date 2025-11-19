return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      auto_install = true,
      automatic_enable = false,
      ensure_installed = {
        -- Only list if you not use setup_handlers below
        "bashls",
        "docker_compose_language_service",
      },
    },
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Ansible
      -- vim.lsp.config.ansiblels = {
      --   capabilities = capabilities,
      --   filetypes = { "yaml", "yml", "ansible" },
      --   -- root_dir = lspconfig.util.root_pattern("roles", "playbooks")
      -- }
      -- vim.lsp.enable("ansiblels")

      -- Bash
      vim.lsp.config.bashls = {
        capabilities = capabilities,
        filetypes = { "sh", "zsh", "bash" },
      }
      vim.lsp.enable("bashls")

      -- Docker
      vim.lsp.config.dockerls = {
        capabilities = capabilities,
        filetypes = { "dockerfile" },
      }
      vim.lsp.enable("dockerls")

      -- Docker Compose
      vim.lsp.config.docker_compose_language_service = {
        capabilities = capabilities,
        -- filetypes = { "yaml", "yml" },
      }
      vim.lsp.enable("docker_compose_language_service")

      -- Go
      vim.lsp.config.gopls = {
        capabilities = capabilities,
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

      -- Lua
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        capabilities = capabilities,
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
        capabilities = capabilities,
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- typeCheckingMode = "off",
              -- autoSearchPaths = true,
              -- useLibraryCodeForTypes = true,
              -- diagnosticMode = "workspace",
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      }
      vim.lsp.enable("pyright")

      -- Ruff
      vim.lsp.config.ruff = {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
        init_options = {
          settings = {
            logLevel = "info",
          },
        },
        capabilities = capabilities,
      }
      vim.lsp.enable("ruff")

      -- Terraform
      vim.lsp.config.terraformls = {
        capabilities = capabilities,
        filetypes = { "tf", "terraform", "hcl" },
      }
      vim.lsp.enable("terraformls")

      -- Texlab
      vim.lsp.config.texlab = {
        capabilities = capabilities,
      }
      vim.lsp.enable("texlab")

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
                  url = "https://github.com/fluxcd/kustomize-controller/releases/download/v1.7.2/kustomize-controller.crds.yaml",
                },
                {
                  description = "Flux Source Controller CRDs",
                  fileMatch = { "source-controller.crds.yaml" },
                  name = "source-controller.crds.yaml",
                  url = "https://github.com/fluxcd/source-controller/releases/download/v1.7.3/source-controller.crds.yaml",
                },
              },
            }),
          },
        },
      }
      vim.lsp.enable("yamlls")

      -- Navigation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

      -- Refactor / actions
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      -- Diagnostics
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
      -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})  -- set for open picker
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

      -- Autoformat
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          local clients = vim.lsp.get_clients({ bufnr = args.buf })
          if #clients > 0 then
            vim.lsp.buf.format({ async = false, bufnr = args.buf })
          end
        end,
      })
      local opts = {}
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      -- Format on save using Ruff for Python files
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function(args)
          vim.lsp.buf.format({
            async = false,
            bufnr = args.buf,
            filter = function(client)
              return client.name == "ruff"
            end,
          })
        end,
      })

      -- Manual format keybinding
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({
          async = true,
          filter = function(client)
            return client.name == "ruff"
          end,
        })
      end, { desc = "Format with Ruff" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "ansiblels",
        "ansible-lint", -- 24.2.0 on arch
        -- { "ansible-lint", version = "6.10.0", auto_update = false }, -- ubuntu 20.04
        "bashls",
        "docker-compose-language-service",
        "dockerls",
        "gopls",
        "hadolint",
        "lua_ls",
        "markdownlint",
        "pyright",
        "ruff",
        "selene",
        "shellcheck",
        -- "shellharden", -- needs cargo
        "shfmt",
        "stylua",
        "terraformls",
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
