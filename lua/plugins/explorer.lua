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
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 30,
            },
          },
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
