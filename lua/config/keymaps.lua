--
-- KEYMAPS
--

-- disable space for leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

-- Remap window navigation
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Remap buffer navigation
vim.keymap.set("n", "<S-h>", ":bprev<CR>", {})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {})

-- Resize panes
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", {})
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", {})
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", {})
vim.keymap.set("t", "<C-Up>", "<cmd>resize -2<CR>", {})
vim.keymap.set("t", "<C-Down>", "<cmd>resize +2<CR>", {})
vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<CR>", {})
vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<CR>", {})

-- Yank entire file
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Paste and do not overwrite buffer
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>p", '"+p')

-- Delete into void buffer
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Paste and do not overwrite buffer
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>p", '"+p')

-- Delete into void buffer
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Move selected lines in visual mode up, down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Select entire file
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Trouble
vim.keymap.set("n", "<leader>tr", [[:TroubleToggle<CR>]])

-- Buffer delete
vim.keymap.set("n", "<leader>bd", [[:bdelete]])
