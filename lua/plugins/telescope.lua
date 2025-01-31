-- Telescope
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- telescope settings
    local builtin = require("telescope.builtin")
    -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.api.nvim_set_keymap(
      "n",
      "<Leader>ff",
      ':lua require"telescope.builtin".find_files({ find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" } })<CR>',
      { noremap = true, silent = true }
    )
    vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({
        -- Add or modify the vimgrep_arguments to include hidden files
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- This flag tells rg to include hidden files
          "--glob",
          "!.git/", -- You might want to exclude .git directory explicitly
        },
      })
    end, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", {})
  end,
}
