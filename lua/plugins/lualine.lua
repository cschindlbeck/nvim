return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-mini/mini.nvim" }, -- replaces "nvim-tree/nvim-web-devicons"
  opts = {
    options = {
      theme = "nord",
      sections = {
        lualine_b = { "diagnostics" },
        lualine_c = { "vim.lsp.status" },
      },
    },
  },
}
