# ⚡ Neovim config

![lualint](https://github.com/cschindlbeck/nvim/actions/workflows/lint.yml/badge.svg)

Chris' neovim config files in lua based on 💤 lazy plugin manager

## 🔋 Includes

- 3 selectable colorschemes (go to lua/plugins/colorscheme.lua and change last line)
- 4 selectable codepilots (go to lua/plugins/codepilot.lua and change last line)

## TODOs

keymaps not working, leader is cleared prematurely

## Install

```bash
git clone https://github.com/cschindlbeck/nvim.git ~/.config/nvim
```

## Requirements

NVIM v9.5.0

## Code Quality

Using pre-commit for linting/formatting, needs

- luacheck

- stylua

- markdownlint

Install via

```bash
pre-commit install
```

or run manually via

```bash
pre-commit run -a
```
