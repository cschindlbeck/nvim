-- luacheck: globals Snacks
return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      hidden = true,
      ignored = false,
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
        Snacks.picker.explorer()
      end,
      desc = "Toggle Explorer",
    },
  },
}
