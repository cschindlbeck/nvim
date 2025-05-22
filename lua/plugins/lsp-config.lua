return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      auto_install = true,
      ensure_installed = {
        -- "ansiblels",
        "bashls",
        "docker_compose_language_service",
        "dockerls",
        "jedi_language_server",
        "lua_ls",
        "pyright",
        "terraformls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      -- lspconfig.ansiblels.setup({
      --   capabilities = capabilities,
      --   filetypes = { "yaml", "yml", "ansible" },
      --   -- root_dir = lspconfig.util.root_pattern("roles", "playbooks")
      -- })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
      -- lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({
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
      })

      lspconfig.pyright.setup({
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
      })
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        filetypes = { "terraform", "tf", "hcl" },
        root_dir = function(fname)
          return require("lspconfig").util.root_pattern(
            ".terraform",
            "main.tf",
            "variables.tf",
            "outputs.tf",
            "terraform.tfvars"
          )(fname) or require("lspconfig").util.path.dirname(fname)
        end,
      })
      lspconfig.texlab.setup({ capabilities = capabilities })
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            schemas = {
              kubernetes = "k8s-*.yaml",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["https://github.com/flux-iac/tofu-controller/releases/download/v0.15.1/tf-controller.crds.yaml"] = "tf-controller.crds.yaml",
              ["https://github.com/fluxcd/kustomize-controller/releases/download/v1.3.0/kustomize-controller.crds.yaml"] = "kustomize-controller.crds.yaml",
              ["https://github.com/fluxcd/source-controller/releases/download/v1.3.0/source-controller.crds.yaml"] = "source-controller.crds.yaml",
              ["https://json.schemastore.org/dependabot-2.0"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/drone"] = ".drone.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              -- https://github.com/fluxcd/kustomize-controller/releases/download/v1.3.0/kustomize-controller.crds.yaml
              -- https://github.com/fluxcd/source-controller/releases/download/v1.3.0/source-controller.crds.yaml
              -- https://github.com/flux-iac/tofu-controller/releases/download/v0.15.1/tf-controller.crds.yaml
            },
          },
        },
      })

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- Autoformat
      vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
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
        "docker-compose-language-service",
        "dockerls",
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
