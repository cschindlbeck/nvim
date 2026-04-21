--
-- GLOBAL CONFIGS
--

-- g
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrwPlugin = 1 -- disable netrw
vim.g.loaded_netrw = 1 -- disable netrw

-- opt
local options = {
  clipboard = "unnamedplus", -- connection to the system clipboard
  colorcolumn = "120", -- show vertical column
  expandtab = true, -- enable the use of space in tab
  -- foldenable = true, -- enable fold
  -- foldmethod = "manual", -- manual fold
  hlsearch = true, --
  incsearch = true, --
  ignorecase = true, -- case insensitive searching
  number = true, -- show line numbers
  relativenumber = false, -- relative numbers
  scrollback = 1000000, -- Unlimited scrollback for the terminal buffer
  scrolloff = 15, -- Minimum number of screen lines to keep above/below the cursor
  shelltemp = false, -- Use shell directly instead of temp files (faster for embedded terminals)
  shiftwidth = 2, -- number of spaces in indentation
  sidescrolloff = 8, -- same for the sides
  smartindent = true, --
  softtabstop = 2, -- Number of spaces a <Tab> counts for while editing
  signcolumn = "yes", --
  swapfile = false, -- no annoying swap file
  tabstop = 2, -- number of spaces for tab
  termguicolors = true, --
  timeoutlen = 500, -- set timeout for leaderkey
  undofile = true, --
  updatetime = 50, --
  wrap = true, -- wrap lines
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.o.autocomplete = true
-- vim.o.completeopt = "menu,menuone,noselect"
