return {
  "folke/snacks.nvim",
  ---@type snacks.Config
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
        Snacks.terminal.toggle()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>th",
      function()
        Snacks.terminal.open(nil, { win = { position = "bottom" } })
      end,
      desc = "Open terminal below",
    },
    {
      "<leader>tv",
      function()
        Snacks.terminal.open(nil, { win = { position = "right" } })
      end,
      desc = "Open terminal to the right",
    },
    {
      "<leader>tf",
      function()
        Snacks.terminal.open(nil, { win = { position = "float" } })
        -- Snacks.terminal(nil, { win = { position = "float", size = { width = 10, height = 10 } } })
      end,
      desc = "Open floating terminal",
    },
  },
}
