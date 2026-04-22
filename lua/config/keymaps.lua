--
-- KEYMAPS
--
local silencio = { silent = true, remap = false }

-- disable space/Q
-- vim.keymap.set("n", "<Space>", "<Nop>", silencio)
vim.keymap.set("n", "Q", "<Nop>", silencio)

-- save with control s because muscle memory is a bitch
vim.keymap.set("n", "<C-s>", ":w<CR>", silencio)
vim.keymap.set("i", "<C-s>", "<esc>:w<CR>", silencio)

-- disable highlight of search after esc
vim.keymap.set("n", "<esc>", ":noh<return><esc>", silencio)

-- Use vim motions for window navigation
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  for _, key in ipairs({ "h", "j", "k", "l" }) do
    vim.keymap.set("t", "<C-" .. key .. ">", [[<Cmd>wincmd " .. key .. "<CR>]], opts)
  end
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Remap buffer navigation
vim.keymap.set("n", "<S-h>", ":bprev<CR>", {})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {})

-- Resize panes
for _, direction in ipairs({
  { key = "Up", resize = "-2" },
  { key = "Down", resize = "+2" },
  { key = "Left", resize = "-2", vertical = true },
  { key = "Right", resize = "+2", vertical = true },
}) do
  if direction.vertical then
    vim.keymap.set("n", "<C-" .. direction.key .. ">", ":vertical resize " .. direction.resize .. "<CR>", {})
    vim.keymap.set("t", "<C-" .. direction.key .. ">", "<cmd>vertical resize " .. direction.resize .. "<CR>", {})
  else
    vim.keymap.set("n", "<C-" .. direction.key .. ">", ":resize " .. direction.resize .. "<CR>", {})
    vim.keymap.set("t", "<C-" .. direction.key .. ">", "<cmd>resize " .. direction.resize .. "<CR>", {})
  end
end

-- Select entire file
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Paste and do not overwrite buffer
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>p", '"+p')

-- Yank into clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete into void buffer
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Move selected lines in visual mode up, down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Sane defaults
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Buffer delete
vim.keymap.set("n", "<leader>bd", [[:bdelete<CR>]], { silent = true, noremap = true })

-- Insert empty line above/below (m keeps cursor in place)
vim.keymap.set("n", "<CR>", "m`o<Esc>``", silencio)
vim.keymap.set("n", "<S-CR>", "m`O<Esc>``", silencio)

--
-- COPILOT NES
--
-- Clear NES suggestion with Esc in normal mode; no-op if no suggestion is active
vim.keymap.set("n", "<esc>", function()
  require("copilot-lsp.nes").clear()
end, { desc = "Clear Copilot NES suggestion", silent = true })
