--
-- KEYMAPS
--

-- function _G.set_terminal_keymaps()
-- local opts = { buffer = 0 }
-- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
-- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
-- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
-- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
-- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
-- end

-- Remap window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})

-- Remap buffer navigation
vim.keymap.set("n", "<S-h>", ":bprev<CR>", {})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {})

-- Yank entire file
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Paste and do not overwrite buffer
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>p", '"+p')

-- Delete into void buffer
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Move selected lines in visual mode up, down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank entire file
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Paste and do not overwrite buffer
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>p", '"+p')

-- Delete into void buffer
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Move selected lines in visual mode up, down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Trouble
vim.keymap.set("n", "<leader>tr", [[:TroubleToggle<CR>]])
