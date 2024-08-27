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
        "ansiblels",
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
      lspconfig.ansiblels.setup({
        capabilities = capabilities,
        filetypes = { "yaml", "yml", "ansible" },
        -- root_dir = lspconfig.util.root_pattern("roles", "playbooks")
      })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
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
      -- lspconfig.yamlls.setup({})

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
        "ansiblels", -- 1.2.1 on arch
        -- { "ansible-lint", version = "6.10.0", auto_update = false }, -- ubuntu 20.04
        "ansible-lint", -- 24.2.0 on arch
        "bashls",
        "black",
        "docker-compose-language-service",
        "dockerls",
        "gopls",
        "hadolint",
        "isort",
        "lua_ls",
        "markdownlint",
        "pylama",
        "pylint",
        "pyright",
        "selene",
        "shellcheck",
        "shellharden",
        "shfmt",
        "stylua",
        "terraformls",
        -- "yaml-language-server",
        "yamlfmt",
        "yamllint",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
