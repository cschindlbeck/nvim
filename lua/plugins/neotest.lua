-- Go test runner: neotest + neotest-golang (debug via nvim-dap-go, see dap.lua)
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    { "fredrikaverpil/neotest-golang", version = "*" },
    "leoluz/nvim-dap-go",
  },
  keys = {
    {
      "<leader>nn",
      function()
        require("neotest").run.run()
      end,
      desc = "Test nearest",
    },
    {
      "<leader>nf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Test file",
    },
    {
      "<leader>nd", -- codespell:ignore nd
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
    {
      "<leader>nl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Test last",
    },
    {
      "<leader>ns",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Test summary",
    },
    {
      "<leader>no",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Test output",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({
          -- gotestsum is recommended by neotest-golang (brew install gotestsum), fall back to go test
          runner = vim.fn.executable("gotestsum") == 1 and "gotestsum" or "go",
        }),
      },
    })
  end,
}
