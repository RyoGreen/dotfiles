# Neovim

Lua-based Neovim config managed with [lazy.nvim](https://github.com/folke/lazy.nvim).
Leader key is `Space`.

## Requirements

Installed automatically by the repo's `setup.sh` (Homebrew):

- `neovim`, `ripgrep` (`rg`), `fd`, `fzf`
- JetBrainsMono Nerd Font (for devicons / lualine)

Language servers are installed on demand by [mason.nvim](https://github.com/williamboman/mason.nvim)
inside Neovim — no manual `cargo`/`npm` step is needed.

## Layout

```
init.lua              -- lazy.nvim bootstrap + plugin declarations (specs)
lua/core/             -- options, keymaps, globals (loaded via require("core"))
lua/plugins/          -- per-plugin settings, loaded via require("plugins")
lua/utils/            -- helper functions
lua/autocmds/         -- autocommands
lazy-lock.json        -- pinned plugin versions
```

`init.lua` declares *which* plugins to install; `lua/plugins/*.lua` holds the
*settings* for them. The two are kept separate on purpose.

## Language servers (mason-lspconfig)

Auto-installed: `gopls`, `rust_analyzer`, `ts_ls`.
Enabling is done explicitly in `lua/plugins/lsp.lua` (`automatic_enable = false`).

## Formatting

[conform.nvim](https://github.com/stevearc/conform.nvim) with format-on-save:

- Web languages (JS/TS/JSON/CSS/HTML/YAML/Markdown/GraphQL/Vue/Svelte) → `prettier`
  (respects a project-local `.prettierrc` / prettier binary)
- Go → `vim-goimports` (handled separately, skipped by conform)
- Other filetypes → attached LSP (e.g. `rust_analyzer` → `rustfmt`)

Manual format: `<leader>F`.

## Key mappings

| Shortcut            | Action                              |
|---------------------|-------------------------------------|
| `<leader>e`         | Toggle file tree (nvim-tree)        |
| `<leader>f`         | Reveal current file in tree         |
| `<leader>n`         | Focus file tree                     |
| `Ctrl-f`            | Find files (fzf-lua)                |
| `<leader>a`         | Find files incl. hidden/ignored     |
| `Ctrl-l`            | Live grep (fzf-lua)                 |
| `<leader>bb`        | Switch buffer (fzf-lua)             |
| `<leader>ls` / `lS` | LSP document / workspace symbols    |
| `<leader>gb`        | Git branches (fzf-lua)              |
| `<leader>F`         | Format buffer (conform)             |
| `Tab` / `Shift-Tab` | Next / prev tab                     |
| `sv` / `sn`         | Split vertical / horizontal         |
| `sh` / `sl`         | Move to prev / next window          |
| `Ctrl-s`            | Save                                |
| `<leader>tt`        | Toggle floating terminal (floaterm) |
| `F7`/`F8`/`F9`      | New / prev / next floaterm          |

Filetype-local (Go, TS/TSX, JS React, Rust):

| Shortcut  | Action                    |
|-----------|---------------------------|
| `Ctrl-]`  | Go to definition          |
| `gd`      | Go to implementation      |
| `Ctrl-t`  | Jump back                 |

Go only: `<leader>i` implement, `<leader>r` referrers.

## Completion & AI

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (LSP / buffer / path sources), LuaSnip
- GitHub Copilot: `Ctrl-l` accept, `Ctrl-c` dismiss (insert mode)
