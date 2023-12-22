--
-- GLOBAL CONFIGS
--

-- g
vim.g.mapleader = " "

-- opt
local options = {
    clipboard = "unnamedplus", -- connection to the system clipboard
    colorcolumn = "120",       -- show vertical column
    expandtab = true,          -- enable the use of space in tab
    ignorecase = true,         -- case insensitive searching
    number = true,             -- show line numbers
    relativenumber = false,    -- relative numbers
    scrolloff = 15,            -- stop scrolling at the top and bottom until the end
    shiftwidth = 4,            -- number of spaces in indentation
    sidescrolloff = 8,         -- same for the sides
    softtabstop = 4,           --
    swapfile = false,          -- no annoying swap file
    tabstop = 4,               -- number of spaces for tab
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
