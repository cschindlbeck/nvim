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
			':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
