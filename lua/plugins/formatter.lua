return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters = {
        yamlfmt = {
          command = "yamlfmt --global_conf", -- Ensure yamlfmt is in your PATH
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
