# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This repo already has an `AGENTS.md` with detailed build/lint/test commands, project structure,
and code style guidelines (formatting, naming, module patterns, keymaps, comments, error handling).
**Read `AGENTS.md` first and follow it as the primary reference.**

## Notes not covered in AGENTS.md

- Avante.nvim (`lua/plugins/avante.lua`) is disabled — it ends with `return {}` (the real spec is
  commented out as `-- return avante`). Copilot is the only active AI assistant. Don't re-enable
  Avante unless asked to.

- This is the user's personal editor config, installed at `~/.config/nvim` — changes take effect
  immediately on next Neovim launch (or `:Lazy reload <plugin>` for a single plugin), there's no
  separate build/deploy step.
- To test a change interactively: launch `nvim` and exercise the affected feature directly (a
  keymap, an LSP action, a plugin UI) rather than assuming the config is correct from reading it.
- `:checkhealth` and `:Lazy` (plugin manager UI) are the primary in-editor diagnostics when a
  plugin fails to load or a keymap doesn't behave as expected.
