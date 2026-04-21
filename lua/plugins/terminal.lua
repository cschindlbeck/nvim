-- luacheck: globals Snacks
return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        -- for a bottom split terminal, setting a fixed height (in lines)
        size = { height = 15 },
      },
    },
  },
  keys = {
    {
      "<leader>tt",
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.terminal.toggle()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>th",
      ---@diagnostic disable-next-line:undefined-global
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.terminal.open(nil, { win = { position = "bottom" } })
      end,
      desc = "Open terminal below",
    },
    {
      ---@diagnostic disable-next-line:undefined-global
      "<leader>tv",
      ---@diagnostic disable-next-line:undefined-global
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.terminal.open(nil, { win = { position = "right" } })
      end,
      desc = "Open terminal to the right",
    },
    ---@diagnostic disable-next-line:undefined-global
    {
      ---@diagnostic disable-next-line:undefined-global
      "<leader>tf",
      ---@diagnostic disable-next-line:undefined-global
      function()
        ---@diagnostic disable-next-line:undefined-global
        Snacks.terminal.open(nil, { win = { position = "float" } })
        -- Snacks.terminal(nil, { win = { position = "float", size = { width = 10, height = 10 } } })
      end,
      desc = "Open floating terminal",
    },
  },
}
