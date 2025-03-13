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
  keys = (function()
    local last_position = "bottom" -- Default position

    local function toggle_last_terminal()
      Snacks.terminal.toggle(nil, { win = { position = last_position } })
    end

    return {
      {
        "<leader>tt",
        toggle_last_terminal,
        desc = "Toggle last opened terminal",
      },
      {
        "<leader>th",
        function()
          last_position = "bottom"
          Snacks.terminal.open(nil, { win = { position = "bottom" } })
        end,
        desc = "Open terminal below",
      },
      {
        "<leader>tv",
        function()
          last_position = "right"
          Snacks.terminal.open(nil, { win = { position = "right" } })
        end,
        desc = "Open terminal to the right",
      },
      {
        "<leader>tf",
        function()
          last_position = "float"
          Snacks.terminal.open(nil, { win = { position = "float" } })
        end,
        desc = "Open floating terminal",
      },
    }
  end)(),
}
