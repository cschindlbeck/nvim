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
    "towolf/vim-helm",
    ft = "helm",
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

      -- Helm (using helm_ls)
      vim.lsp.config.helm_ls = {
        -- helm_ls needs the "serve" argument
        cmd = { "helm_ls", "serve" },
        -- helm-ls provides completions for Helm charts and Helmfile etc.
        filetypes = { "helm", "helmfile", "yaml", "yml" },
        capabilities = capabilities, -- reuse your capabilities var
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
        "black",
        "docker-compose-language-service",
        "dockerls",
        "gopls",
        "hadolint",
        "helm_ls",
        "isort",
        "lua_ls",
        "markdownlint",
        "pylama",
        "pylint",
        "pyright",
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
