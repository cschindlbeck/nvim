-- Colorscheme settings
-- Select your colorscheme in the last line

-- Catppucin theme
local catppuccin = {
  "catppuccin/nvim",
  name = "catpuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}

-- Nord
local nord = {
  "gbprod/nord.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("nord")
    local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = fg })
    vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = fg })
  end,
}

-- Dracula theme
local dracula = {
  -- add dracula
  { "Mofiqul/dracula.nvim" },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}

-- VSCode theme
local vscode = {
  "Mofiqul/vscode.nvim",
  config = function()
    -- Lua:
    -- For dark theme (neovim's default)
    vim.o.background = "dark"

    local c = require("vscode.colors").get_colors()
    require("vscode").setup({
      -- Alternatively set style in setup
      -- style = 'light'

      -- Enable transparent background
      transparent = false,

      -- Enable italic comment
      italic_comments = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        vscLineNumber = "#FFFFFF",
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      },
    })
    require("vscode").load()
  end,
}

return nord
