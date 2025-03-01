return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", {})
    end,
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      lazygit = {
        enabled = true,
      },
    },
  },
  vim.api.nvim_set_keymap(
    "n",
    "<leader>lg",
    ':lua require("snacks").lazygit.open()<CR>',
    { noremap = true, silent = true }
  ),
}
