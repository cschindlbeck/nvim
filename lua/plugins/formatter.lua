-- conform.nvim
return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters = {
        black = {
          command = "black",
          args = { "--line-length=160", "--skip-string-normalization", "-" },
          stdin = true,
        },
        isort = {
          command = "isort",
          args = { "-" },
          stdin = true,
        },
        markdownlint = {
          command = "markdownlint",
          args = { "--fix", "--max-line-length=120" },
          stdin = true,
        },
        stylua = {
          command = "stylua",
          args = { "--indent-width", "2", "--indent-type", "Spaces", "--column-width", "120", "-" },
          stdin = true,
        },
        shfmt = {
          command = "shfmt",
          args = { "-i", "2", "-ci" },
          stdin = true,
        },
        terraform_fmt = {
          command = "terraform",
          args = { "fmt", "-" },
          stdin = true,
        },
        yamlfmt = {
          command = "yamlfmt",
          args = { "--global_conf", "-" },
          -- args = { "--offset,", "0" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        python = { "isort", "black" },
        lua = { "stylua" },
        markdown = { "markdownlint" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        yaml = { "yamlfmt" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
    })

    -- optional keymap
    vim.keymap.set("n", "<leader>gf", function()
      require("conform").format({ async = true })
    end, { desc = "Format file" })
  end,
}
