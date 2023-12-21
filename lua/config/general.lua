--
-- GLOBAL CONFIGS
--

-- cmd
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- g
vim.g.mapleader = " "

-- opt
local options = {
  colorcolumn = "120",
  scrolloff = 15,
  sidescrolloff = 8,
  swapfile = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
