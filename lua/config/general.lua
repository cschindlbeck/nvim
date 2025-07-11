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
  scrolloff = 15, -- stop scrolling at the top and bottom until the end
  shiftwidth = 2, -- number of spaces in indentation
  sidescrolloff = 8, -- same for the sides
  smartindent = true, --
  softtabstop = 2, --
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
