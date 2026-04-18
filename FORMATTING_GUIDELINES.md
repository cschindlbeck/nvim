# Formatting Guidelines

To ensure consistent code formatting and linting across the project, this document outlines the configured tools and their usage:

## Tools Used

1. **StyLua** (Code Formatter):
   - Formatting control is defined explicitly in `.stylua.toml`.
   - Column width, indentation rules, and other formatting standards are strictly enforced.

2. **Luacheck** (Linter):
   - Linting standards, such as allowed globals and maximum line lengths, are controlled via `.luacheckrc`.

## Configuration Overview

### `.stylua.toml` Configuration
```toml
column_width = 120
indent_type = "Spaces"
indent_width = 2
line_endings = "Unix"
```
- The above configuration ensures all files are formatted with a consistent 120-character column width, 2-space indentation, and Unix-style line endings.

### `.luacheckrc` Configuration
```lua
max_line_length = 120
max_code_line_length = 120
max_string_line_length = 120
max_comment_line_length = 120
globals = {
  "vim",
}
ignore = { "211" }
```
- Maximum line lengths for code and comments align with StyLua rules.

## Usage

### Editor Integration
- Formatting is handled via `null-ls` with StyLua integration.
- Use the `<leader>gf` shortcut to invoke formatting within Neovim.

### Manual Formatting
- CLI: `stylua path/to/file.lua`

### Manual Linting
- CLI: `luacheck path/to/file.lua`

## Validation

To validate formatting and linting across the project:
1. Format files using StyLua (Editor or StyLua CLI).
2. Lint files to ensure compliance with `.luacheckrc`:
   ```bash
   luacheck path/to/file.lua
   ```
3. Check pre-commit hooks during commits.

---
Following these guidelines will prevent conflicts between formatting and linting tools in the project.