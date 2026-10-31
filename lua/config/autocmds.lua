-- Autocommand creation is slightly more verbose,
-- but they're also a bit more readable than the Vim equivalent in my opinion.
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  desc = "Briefly highlight yanked text",
  group = augroup("yank", { clear = true }),
})

-- Delete the LSP log at startup when it is larger than 1 GB (the size at which Neovim warns about it).
-- This runs before lazy.nvim starts any LSP client, so no client has the file open yet.
local lsp_log = vim.fs.joinpath(vim.fn.stdpath("log"), "lsp.log")
local lsp_log_stat = vim.uv.fs_stat(lsp_log)
if lsp_log_stat and lsp_log_stat.size > 1e9 then
  os.remove(lsp_log)
  vim.notify(string.format("Deleted %s (%d MB)", lsp_log, math.floor(lsp_log_stat.size / 1e6)))
end
