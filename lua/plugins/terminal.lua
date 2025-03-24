return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        size = { height = 15 },
      },
    },
  },
  keys = (function()
    local last_position = "bottom"

    local function safe_close()
      -- Gracefully handle missing terminal
      pcall(require("snacks.terminal").close)
    end

    return {
      {
        "<leader>tc",
        function()
          local snacks = require("snacks.terminal")
          snacks.close()
        end,
        desc = "Close terminal",
      },
      {
        "<leader>tt",
        function()
          local snacks = require("snacks.terminal")
          -- Toggle or create new terminal if none exists
          if not snacks.exists() then
            snacks.open(nil, { win = { position = last_position } })
          else
            snacks.toggle()
          end
        end,
        desc = "Toggle last opened terminal",
      },
      {
        "<leader>th",
        function()
          safe_close()
          last_position = "bottom"
          require("snacks.terminal").open(nil, { win = { position = "bottom" } })
        end,
        desc = "Open terminal below",
      },
      {
        "<leader>tv",
        function()
          safe_close()
          last_position = "right"
          require("snacks.terminal").open(nil, { win = { position = "right" } })
        end,
        desc = "Open terminal to the right",
      },
      {
        "<leader>tf",
        function()
          safe_close()
          last_position = "float"
          require("snacks.terminal").open(nil, { win = { position = "float" } })
        end,
        desc = "Open floating terminal",
      },
    }
  end)(),
}
