return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  init = function()
    -- Ensure parsers and configure highlighting/indentation
    local ensureInstalled = { "lua", "python", "typescript" }
    local alreadyInstalled = require("nvim-treesitter.config").get_installed()
    local parsersToInstall = vim
      .iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()
    require("nvim-treesitter").install(parsersToInstall)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
