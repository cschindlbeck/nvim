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
        ---@diagnostic disable-next-line:undefined-global
        ---@diagnostic disable-next-line:undefined-global
        Snacks.picker.recent({ filter == { cwd = true } })
      end,
      desc = "Recent files",
    },
    {
      "<leader>fb",
      ---@diagnostic disable-next-line:undefined-global
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.picker.buffers()
      end,
      desc = "Search buffers",
    },
    {
      ---@diagnostic disable-next-line:undefined-global
      "<leader>ff",
      ---@diagnostic disable-next-line:undefined-global
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.picker.smart()
      end,
      desc = "Find files",
    },
    ---@diagnostic disable-next-line:undefined-global
    {
      ---@diagnostic disable-next-line:undefined-global
      "<leader>fg",
      ---@diagnostic disable-next-line:undefined-global
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
  },
}
