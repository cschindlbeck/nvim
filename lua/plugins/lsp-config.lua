return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                -- "clangd",
                -- "cmake-language-server",
                -- "codelldb",
                -- "codespell",
                -- "cpplint",
                -- "cpptools",
                -- "docker-compose-language-service",
                -- "dockerfile-language-server",
                -- "eslint-lsp",
                -- "eslint_d",
                -- "flake8",
                -- "hadolint",
                -- "jedi-language-server",
                -- "json-lsp",
                -- "llm-ls",
                -- "lua-language-server",
                "lua_ls",
                -- "prettier",
                "pyright",
                -- "rust-analyzer",
                -- "shellcheck",
                -- "shfmt",
                -- "stylua",
                -- "tablo",
                -- "texlab",
                "terraformls",
                -- "xmlformatter",
                -- "yaml-language-server",
                -- "yamlfmt",
                -- "yamllint",
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        -- this alternative should work, but it doesnt
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
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.terraformls.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)
        end
    },

}
