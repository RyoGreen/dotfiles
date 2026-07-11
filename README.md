# dotfiles for macOS

Config files for yabai + skhd, Neovim, tmux, Zsh, and Starship.
Run `./setup.sh` to symlink everything and install the required packages.

Requires macOS with [Homebrew](https://brew.sh). Leader key in Neovim is `Space`.

## Contents

| File / Dir              | Purpose                          |
|-------------------------|----------------------------------|
| `.yabairc`              | yabai (tiling window manager)    |
| `.skhdrc`               | skhd (hotkeys)                   |
| `.config/nvim/`         | Neovim (lazy.nvim, LSP, fzf-lua) |
| `tmux.conf`             | tmux                             |
| `.zshrc`                | Zsh                              |
| `.config/starship.toml` | Starship prompt                  |

## Neovim

| Shortcut          | Action                        |
|-------------------|-------------------------------|
| `space e`         | Toggle file tree (nvim-tree)  |
| `space f`         | Reveal current file in tree   |
| `space a`         | Find files (fzf, incl. ignored)|
| `Ctrl-f`          | Find files (fzf)              |
| `Ctrl-l`          | Live grep (fzf)               |
| `space bb`        | Switch buffer (fzf)           |
| `space F`         | Format buffer (conform)       |
| `Tab` / `Shift-Tab` | Next / prev buffer          |
| `space t t`       | Toggle floating terminal      |
| `sv` / `sn`       | Split vertical / horizontal   |
| `Ctrl-s`          | Save                          |
| `gd` / `Ctrl-]`   | Go to implementation / definition |

## Keyboard Shortcuts (.skhdrc)

All shortcuts control yabai.

| Shortcut                | Action                      |
|-------------------------|-----------------------------|
| `alt - h/j/k/l`         | Focus west/south/north/east |
| `alt - x`               | Focus most recent window    |
| `alt - z / c`           | Focus prev / next in stack  |
| `alt - f`               | Toggle fullscreen zoom      |
| `shift + alt - h/j/k/l` | Swap window                 |
| `shift + cmd - h/j/k/l` | Warp window                 |
| `cmd + alt - 1..9,0`    | Focus space 1–10            |
| `cmd + alt - x/z/c`     | Focus recent / prev / next space |
| `shift + cmd - x`       | Send window to recent space |
| `ctrl + alt - 1..3`     | Focus display 1–3           |
| `ctrl + cmd - 1..3`     | Send window to display 1–3  |

## tmux

Prefix is `C-g`. `prefix + v` / `s` to split, `h/j/k/l` to move between panes.

## Zsh

`cd` with no argument opens a [zoxide](https://github.com/ajeetdsouza/zoxide)
picker; `Ctrl-r` searches history via fzf.
