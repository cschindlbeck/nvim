return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        vim.keymap.set("n", "<leader>tt", [[:ToggleTerm direction=vertical<CR>]])
        require("toggleterm").setup({
            direction = "horizontal", -- Set the default direction

            -- Define a function to determine the size dynamically based on the term.direction
            size = function(term)
                if term.direction == "horizontal" then
                    return vim.api.nvim_get_option("lines") * 0.4
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end
        })
    end,
}
