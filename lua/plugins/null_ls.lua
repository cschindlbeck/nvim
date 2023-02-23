-- see https://alpha2phi.medium.com/neovim-for-beginners-lsp-using-null-ls-nvim-bd954bf86b40
return {

  -- local sources = {
  --   -- formatting
  --   -- diagnostics
  --   -- code
  --
  -- }
  -- local nls = require "null-ls"
  -- local b = nls.builtins

  require("null-ls").setup({
    sources = {
      require("null-ls").builtins.formatting.shfmt, -- shell script formatting
      require("null-ls").builtins.diagnostics.shellcheck, -- shell script diagnostics
      require("null-ls").builtins.diagnostics.flake8, -- flake8




    },
  })
}
