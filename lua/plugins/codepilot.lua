-- Codepilot settings
-- Select your chosen one in the last line

-- ChatGPT (This needs credits on openai)
-- OPENAI_API_KEY must be set via e.g.
-- export OPENAI_API_KEY=<my-token>
local chatgpt = {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "echo $OPENAI_API_KEY",
    })
  end,
}

-- Github copilot
-- First time enter Copilot setup and then press enter again (bug in notification plugin)
-- Then the browser pops up and asks for a code, the code is in the clipboard so just middle mouse button

local github = {
  "github/copilot.vim",
}

-- LLM nvim open-source copilot clone with ghost text completion
-- LLM_NVIM_API_TOKEN must be set via e.g.
-- export LLM_NVIM_API_TOKEN=<my-token>
-- works only with gilbc >= 2.32, which is not on ubuntu 20.04
local llm = {
  "huggingface/llm.nvim",
  opts = {
    tokens_to_clear = { "<EOT>" },
    fim = {
      enabled = true,
      prefix = "<PRE> ",
      middle = " <MID>",
      suffix = " <SUF>",
    },
    accept_keymap = "<C-g>",
    dismiss_keymap = "<S-Tab>",
    model = "codellama/CodeLlama-13b-hf",
    context_window = 4096,
    tokenizer = {
      repository = "codellama/CodeLlama-13b-hf",
    },
    lsp = {
      bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
      version = "0.2.1",
    },
  },
}

-- Codeium
-- first time, please enter Codeium Auth and paste API token after the browser automatically pops up
-- Working but most keybinds don't work
local codeium = {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    vim.keymap.set({ "i", "s" }, "<C-g>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true })
    vim.keymap.set({ "i", "s" }, "<a-n>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true })
    vim.keymap.set({ "i", "s" }, "<a-p>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true })
    vim.keymap.set({ "i", "s" }, "<c-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true })
  end,
}

return {}
