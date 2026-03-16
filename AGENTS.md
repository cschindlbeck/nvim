# AGENTS.md — Neovim Configuration Repository

Personal Neovim configuration using **lazy.nvim** as plugin manager.
100% Lua codebase — no Vimscript.

Repository: <https://github.com/cschindlbeck/nvim>

## Build / Lint / Test Commands

There is no build step or test suite. Quality is enforced via pre-commit hooks
and CI.

### Pre-commit (primary quality gate)

```bash
# Install hooks (runs automatically on every git commit)
pre-commit install

# Run all hooks against all files
pre-commit run -a

# Run a single hook
pre-commit run stylua -a      # Lua formatting
pre-commit run luacheck -a    # Lua linting
pre-commit run codespell -a   # Spellcheck
pre-commit run yamlfmt -a     # YAML formatting
pre-commit run markdownlint -a # Markdown linting
```

### Individual tool commands

```bash
# Lua formatter (canonical settings — match pre-commit config)
stylua --indent-width 2 --indent-type Spaces --column-width 120 lua/

# Lua linter (uses .luacheckrc for config)
luacheck lua/

# Update pre-commit hook versions
pre-commit autoupdate
```

### CI Pipeline

CI runs on push to `main` and on pull requests (`.github/workflows/pre-commit.yml`):

1. `luacheck` via `lunarmodules/luacheck@v1`
2. `pre-commit run` (with luacheck skipped to avoid double-run)

## Project Structure

```text
init.lua                  Entry point: bootstraps lazy.nvim, loads config, sets up plugins
lua/
  config/
    general.lua           vim.opt / vim.g settings (leader, indent, UI)
    autocmds.lua          Autocommands
    keymaps.lua           Global keybindings
    diagnostics.lua       Diagnostic display config
  plugins/
    <feature>.lua         One file per feature/concern, each returns a lazy.nvim spec
```

**Load order** (defined in `init.lua`):
`config/general` → `config/autocmds` → `config/keymaps` → `config/diagnostics` → `lazy.setup("plugins")`

Plugin files are organized **by feature** (e.g., `git.lua` groups gitsigns, fugitive,
git-conflict), not by plugin name.

## Code Style Guidelines

### Formatting (enforced by StyLua + luacheck)

- **Indentation**: 2 spaces (no tabs)
- **Column width**: 120 characters (StyLua). luacheck allows up to 160.
- **Trailing commas**: Always, on every table entry including the last
- **String quotes**: Double quotes (`"..."`) exclusively. Use `[[ ]]` only for
  strings containing quotes or special characters (e.g., `[[<C-\><C-n>]]`)
- **Empty tables**: Inline (`opts = {}`)
- **Multi-entry tables**: One entry per line, 2-space indent per nesting level

### Naming Conventions

- **Variables**: `snake_case` exclusively (e.g., `local lazy_path`, `local capabilities`)
- **No camelCase** for user-defined names. camelCase only appears in table keys
  dictated by external APIs (e.g., LSP `completeUnimported`)
- **Short names** only for universally-understood objects (`cmp`, `lsp`)

### Imports / Requires

- External plugin `require()` calls go **inside** `config = function()` bodies
  (never at file top level) — this preserves lazy-loading
- Neovim API aliases go at file top level:
  `local autocmd = vim.api.nvim_create_autocmd`
- Always use `local` for require results: `local cmp = require("cmp")`
- Inline `require()` is acceptable for one-off calls:
  `require("luasnip.loaders.from_vscode").lazy_load()`

### Module Patterns

- **`lua/config/*`**: Side-effect scripts. Set `vim.opt`, `vim.g`, `vim.keymap`,
  etc. imperatively. **No return value.**
- **`lua/plugins/*`**: Return a lazy.nvim plugin spec table (or list of tables).
  **Always return a table.**
- Do **not** use the `local M = {} ... return M` pattern. This codebase does not
  use it anywhere.

### Functions

- Use anonymous `function()` for all `config` callbacks and event handlers
- Do **not** create `local function name()` declarations — keep functions inline
  or use imperative top-level statements
- The only exception for named functions is `_G.func_name` when called from
  `vim.cmd` strings

### Keymaps

- Use `vim.keymap.set(mode, lhs, rhs, opts)` exclusively
- Always provide an opts table (use `{}` if no options needed)
- For reusable options: `local silencio = { silent = true, remap = false }`
- Mode can be a string (`"n"`) or table (`{ "n", "v" }`)
- RHS can be a string, `[[ ]]` literal, or direct function reference —
  do not wrap single function calls in `function()` wrappers

### Comments

- Single-line `--` comments only (no `--[[ ]]` block comments)
- Section headers use a 3-line ALL CAPS banner:

  ```lua
  --
  -- SECTION NAME
  --
  ```

- Luacheck directives at file top: `-- luacheck: globals Snacks`
- Commented-out code keeps original indentation

### Error Handling

- Minimal — trust the plugin ecosystem and Neovim APIs
- Use guard clauses for preconditions (e.g., check LSP clients exist before
  calling format)
- No `pcall`, `xpcall`, `assert`, or `error()` usage

### Globals

- `vim` is the only declared global (`.luacheckrc`)
- Plugin globals (e.g., `Snacks`) are declared via luacheck directives per file
- Warning 211 (unused locals) is globally ignored in `.luacheckrc`

## Tool Configuration Reference

| Tool          | Config File          | Key Settings                              |
|---------------|----------------------|-------------------------------------------|
| StyLua        | (pre-commit args)    | 2-space indent, 120 column width          |
| luacheck      | `.luacheckrc`        | 160 max line length, `vim` global         |
| lua_ls        | `lua/.luarc.json`    | `vim` as known global                     |
| markdownlint  | `.markdownlint.yaml` | 120 line length, tables exempt            |
| yamlfmt       | `.yamlfmt`           | 120 line length, document start markers   |
| codespell     | (pre-commit args)    | Auto-fix with `--write-changes`           |

## Key Technical Details

- **Plugin manager**: lazy.nvim (bootstrapped in `init.lua`)
- **Leader key**: Space
- **Colorscheme**: Nord (alternatives defined but inactive in `colorscheme.lua`)
- **LSP servers**: bashls, dockerls, docker_compose, gopls, lua_ls, pyright,
  terraformls, texlab, yamlls
- **Formatters via none-ls**: black, isort, stylua, shfmt, terraform_fmt,
  markdownlint, hadolint, yamllint
- **AI assistants**: Copilot (active) + Avante.nvim
- **`lazy-lock.json`** is gitignored — do not commit it
