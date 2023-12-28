return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "bashls",
                -- "clangd",
                -- "cmake-language-server",
                -- "codelldb",
                -- "codespell",
                -- "cpplint",
                -- "cpptools",
                "docker_compose_language_service",
                "dockerls",
                -- "eslint-lsp",
                -- "eslint_d",
                -- "jedi-language-server",
                -- "json-lsp",
                -- "llm-ls",
                -- "lua-language-server",
                "lua_ls",
                "pyright",
                "jedi_language_server",
                -- "tablo",
                -- "texlab",
                "terraformls",
                -- "xmlformatter",
                -- "yaml-language-server",
                -- "yamlfmt",
                "yamlls",
                -- "yamllint",
            },
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

            lspconfig.dockerls.setup({})
            lspconfig.docker_compose_language_service.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.terraformls.setup({})
            lspconfig.yamlls.setup({})

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
                "ansible-lint",
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
                "yaml-language-server",
                "yamlfmt",
                "yamllint",
            },
            auto_update = true,
            run_on_start = true,
        },
    },
}
