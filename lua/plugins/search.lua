-- luacheck: globals Snacks
-- luacheck: globals filter
return {
  "folke/snacks.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    picker = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter == { cwd = true } })
      end,
      desc = "Recent files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Search buffers",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
  },
}
