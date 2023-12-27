return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- formatting
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,

                -- diagnotics
                -- null_ls.builtins.diagnostics.flake8,

                -- completion
                null_ls.builtins.completion.luasnip,
                null_ls.builtins.completion.spell,
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
