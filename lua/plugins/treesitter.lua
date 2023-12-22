return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "dockerfile",
            "gitcommit",
            "gitattributes",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "vim",
            "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
    }
}
