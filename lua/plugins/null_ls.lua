-- see https://alpha2phi.medium.com/neovim-for-beginners-lsp-using-null-ls-nvim-bd954bf86b40
return {
  require("null-ls").setup({
    sources = {
      require("null-ls").builtins.diagnostics.shellcheck, -- shell script diagnostics
      -- require("null-ls").builtins.diagnostics.flake8, -- flake8
      require("null-ls").builtins.diagnostics.pylama.with({
        extra_args = {
          "--max-line-length=120",
        },
      }),
      require("null-ls").builtins.formatting.shfmt, -- shell script formatting
      require("null-ls").builtins.formatting.black.with({
        extra_args = {
          "--line-length=120",
          "--skip-string-normalization"
        },
      })
    },
  })
}
