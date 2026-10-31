return {
  {
    "saghen/blink.cmp",
    -- v2 is under development with breaking changes, stay on v1
    version = "1.*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "default",
        -- accept the first item even if none is selected (same as nvim-cmp confirm with select = true)
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { border = "rounded" },
        documentation = { auto_show = true, window = { border = "rounded" } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      snippets = { preset = "default" },
    },
  },
}
