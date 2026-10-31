-- luacheck: globals Snacks
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
    },
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "folke/snacks.nvim",
    ---@class snacks.Config
    ---@type snacks.Config
    opts = {
      lazygit = {
        enabled = true,
      },
    },
    keys = {
      {
        "<leader>lg",
        function()
          ---@diagnostic disable-next-line:undefined-global
          Snacks.lazygit.open()
        end,
        desc = "Lazygit",
      },
    },
  },
}
