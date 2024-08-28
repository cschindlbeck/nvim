return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters = {
        yamlfmt = {
          command = "yamlfmt", -- Ensure yamlfmt is in your PATH
          args = {
            "-formatter",
            "type=basic,include_document_start=true,max_line_length=120,retain_line_breaks_single=true,indentless_arrays=false,pad_line_comments=2",
          },
          stdin = true, -- Makes yamlfmt read from stdin
        },
      },
      formatters_by_ft = {
        yaml = { "yamlfmt", stop_after_first = true },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
