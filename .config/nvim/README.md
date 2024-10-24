# vim-setting

## language server

- gopls
- typescript-language-server

## path

- /Users/(local_user)/.config/nvim

## font

- jetBrain mono

## telescope

- change layoyt
- change key map to close <C-f>

### ~/.local/share/nvim/plugged/telescope.nvim/lua/telescope/pickers/layout_strategies.lua

- 516: preview.height = 0
- 467: results.height = height - prompt.height - h_space +10

### ~/.local/share/nvim/plugged/telescope.nvim/lua/telescope/mappings.lua

- 139: ["&lt;C-f&gt;"] = actions.close,

# visual studio code

## short cut key

- close tab -> [view:Close Editor] When:- Source:User

## ag

- https://github.com/ggreer/the_silver_searcher
- let g:ag_prg="<custom-ag-path-goes-here> --vimgrep"
