-- none ls wraps command line tools such as linter and formatter as an LSP for neovim to process
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      -- make sure these are installed in mason via mason install tool from lsp-config lua
      sources = {
        ----------------
        -- formatting --
        ----------------
        null_ls.builtins.formatting.black.with({
          extra_args = {
            "--line-length=120",
            "--skip-string-normalization",
          },
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.markdownlint.with({
          extra_args = { "--max-line-length=120" },
        }),
        null_ls.builtins.formatting.stylua, -- appears to be done anyway
        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2", "-ci" },
        }),
        -- null_ls.builtins.formatting.shellharden, -- needs cargo
        null_ls.builtins.formatting.terraform_fmt,
        -- null_ls.builtins.formatting.yamlfmt,
        -- MD013:
        --   # Number of characters
        --   line_length: 80

        -----------------
        -- linter --
        -----------------
        -- null_ls.builtins.diagnostics.ansiblelint,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.markdownlint.with({
          extra_args = { "--max-line-length=120" },
        }),
        -- null_ls.builtins.diagnostics.selene, -- lua needs glibc2.33 not available on ubuntu2004
        -- null_ls.builtins.diagnostics.pylint.with({
        --   diagnostics_postprocess = function(diagnostic)
        --     diagnostic.code = diagnostic.message_id
        --   end,
        -- }),
        null_ls.builtins.diagnostics.yamllint.with({
          extra_args = {
            "-d",
            "{extends: default, rules: {indentation: {spaces: 2, indent-sequences: consistent}, "
              .. "line-length: {max: 150}, document-start: {present: false}}}",
          },
        }),
        ----------------
        -- completion --
        ----------------
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.completion.spell,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
