return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", {})
    end
  },
}
