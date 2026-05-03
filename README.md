# ⚡ Neovim config

![pre-commit](https://github.com/cschindlbeck/nvim/actions/workflows/pre-commit.yml/badge.svg)

Chris' personal Neovim configuration, written entirely in Lua using [💤 lazy.nvim](https://github.com/folke/lazy.nvim).

## 📦 Install

```bash
git clone https://github.com/cschindlbeck/nvim.git ~/.config/nvim
```

## 🔧 Requirements

- **Neovim** ≥ 0.10 (tested against latest stable, currently NVIM v0.12)
- **Git**, **curl** (for lazy.nvim bootstrap)
- **Node.js / npm** (LSP servers, Copilot)
- **A [Nerd Font](https://www.nerdfonts.com/)** (icons in UI)
- **xclip** or **xsel** (clipboard integration on Linux)
- Mason will automatically install all LSP servers, formatters and linters on first launch.

## 🗂️ Structure

```text
init.lua                  Entry point: bootstraps lazy.nvim, loads config, sets up plugins
lua/
  config/
    general.lua           vim.opt / vim.g settings (leader key, indent, UI)
    autocmds.lua          Autocommands
    keymaps.lua           Global keybindings
    diagnostics.lua       Diagnostic display configuration
  plugins/
    avante.lua            Avante.nvim AI chat sidebar
    bufferline.lua        Buffer tab bar (bufferline.nvim)
    codepilot.lua         AI inline completion (Copilot active; ChatGPT, Codeium, llm.nvim selectable)
    colorscheme.lua       Colorscheme (Nord active; Catppuccin, Dracula, VSCode selectable)
    completion.lua        Autocompletion (nvim-cmp + LuaSnip)
    dashboard.lua         Start screen (snacks.nvim dashboard)
    explorer.lua          File explorer (snacks.nvim)
    git.lua               Git integration (gitsigns, fugitive, git-conflict, lazygit)
    lsp-config.lua        LSP servers via mason + nvim-lspconfig
    lualine.lua           Status line (lualine.nvim)
    motions.lua           Enhanced navigation (flash.nvim)
    none-ls.lua           Formatters and linters bridged as LSP (none-ls)
    search.lua            Fuzzy finder and grep (snacks.nvim picker)
    terminal.lua          Integrated terminal (snacks.nvim)
    tmux.lua              Tmux navigation integration
    treesitter.lua        Syntax highlighting and code parsing (nvim-treesitter)
    trouble.lua           Diagnostics list (trouble.nvim)
```

## 🔋 Features

### 🎨 Colorschemes

Selectable in `lua/plugins/colorscheme.lua` (change the `return` at the bottom):

| Scheme | Plugin |
| --- | --- |
| **Nord** *(active)* | `gbprod/nord.nvim` |
| Catppuccin | `catppuccin/nvim` |
| Dracula | `Mofiqul/dracula.nvim` |
| VSCode | `Mofiqul/vscode.nvim` |

### 🤖 AI Assistance

Selectable in `lua/plugins/codepilot.lua`:

| Tool | Plugin | Notes |
| --- | --- | --- |
| **GitHub Copilot** *(active)* | `zbirenbaum/copilot.lua` + `jvune0/copilot-cmp` | Inline completion via nvim-cmp |
| **Avante.nvim** *(active)* | `yetone/avante.nvim` | AI chat sidebar, powered by Copilot |
| ChatGPT | `jackMort/ChatGPT.nvim` | Requires `OPENAI_API_KEY` |
| Codeium | `Exafunction/codeium.vim` | Free alternative |
| llm.nvim | `huggingface/llm.nvim` | Open-source, requires glibc ≥ 2.32 |

### 🧠 LSP Servers

Managed by [Mason](https://github.com/williamboman/mason.nvim) and configured via `nvim-lspconfig`:

`bashls` · `dockerls` · `docker_compose_language_service` · `gopls` · `helm_ls` ·
`lua_ls` · `pyright` · `terraformls` · `texlab` · `yamlls`

### 🖊️ Formatters & Linters

Bridged via [none-ls](https://github.com/nvimtools/none-ls.nvim):

| Type | Tools |
| --- | --- |
| Formatters | `black`, `isort`, `stylua`, `shfmt`, `terraform_fmt`, `markdownlint` |
| Linters | `hadolint`, `markdownlint`, `yamllint` |

### ⌨️ Key Bindings

Leader key: `<Space>`

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files (smart picker) |
| `<leader>fg` | Grep across project |
| `<leader>fr` | Recent files |
| `<leader>fb` | Search open buffers |
| `<leader>e` | Toggle file explorer |
| `<leader>tt` | Toggle terminal |
| `<leader>th` | Open terminal below |
| `<leader>tv` | Open terminal to the right |
| `<leader>tf` | Open floating terminal |
| `<leader>lg` | Open lazygit |
| `<leader>gb` | Git blame |
| `<leader>gp` | Preview git hunk |
| `<leader>gf` | Format buffer |
| `<leader>rn` | LSP rename |
| `<leader>ca` | LSP code action |
| `<leader>tr` | Toggle trouble diagnostics list |
| `gd` / `gD` | Go to definition / declaration |
| `gi` / `gr` | Go to implementation / references |
| `K` | Hover documentation |
| `[d` / `]d` | Previous / next diagnostic |
| `<C-s>` | Save file |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<C-h/j/k/l>` | Navigate splits |
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `<leader>p` | Paste from system clipboard |
| `<leader>d` | Delete to void register |
| `<leader>bd` | Delete buffer |

## 🛡️ Code Quality

[pre-commit](https://pre-commit.com/) is used for all linting and formatting.

Hooks included:

| Hook | Tool | Purpose |
| --- | --- | --- |
| `stylua` | StyLua | Lua formatting (2-space indent, 120 col) |
| `luacheck` | luacheck | Lua linting |
| `codespell` | codespell | Spell check in comments and docs |
| `yamlfmt` | yamlfmt | YAML formatting |
| `markdownlint` | markdownlint | Markdown linting |

Install hooks (runs automatically on every `git commit`):

```bash
pre-commit install
```

Run all hooks manually:

```bash
pre-commit run -a
```
