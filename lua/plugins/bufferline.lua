return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {},
  config = function()
    require("bufferline").setup({
      options = {
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
      },
      highlights = {
        -- buffer = {
        --   fg = "#FFFFFF",
        --   bg = "#011627",
        -- },
        buffer_selected = {
          fg = "#FFFFFF",
          bf = "#011627",
        },
      },
    })
  end,
}
