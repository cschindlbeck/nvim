return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      sources = {
        explorer = {
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        local snacks = require("snacks.picker")
        snacks.explorer()
      end,
      desc = "Toggle Explorer",
    },
  },
}
