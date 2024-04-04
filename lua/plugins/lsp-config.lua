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
        "lua_ls",
        "pyright",
        "jedi_language_server",
        "terraformls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    -- this alternative should work, but it does not
    -- opts = {
    --   servers = {
    --     lua_ls = {},
    --     terraformls = {},
    --     pyright = {
    --       settings = {
    --         python = {
    --           analysis = {
    --             typeCheckingMode = "off",
    --             autoSearchPaths = true,
    --             useLibraryCodeForTypes = true,
    --             diagnosticMode = "workspace",
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
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
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.terraformls.setup({ capabilities = capabilities })
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
        "black",
        "docker-compose-language-service",
        "dockerls",
        "hadolint",
        "isort",
        "lua_ls",
        "markdownlint",
        "pylama",
        "pyright",
        "shfmt",
        "shellcheck",
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
