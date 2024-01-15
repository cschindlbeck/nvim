-- Autocommand creation is slightly more verbose,
-- but they're also a bit more readable than the Vim equivalent in my opinion.
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Briefly highlight yanked text",
  group = augroup("yank", { clear = true }),
})
