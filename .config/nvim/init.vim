let $LANG='en_US.UTF-8'

let mapleader = " "
syntax enable
filetype plugin indent on
runtime ./src/set.vim
call plug#begin()
Plug 'voldikss/vim-floaterm'
Plug 'rking/ag.vim'
Plug 'ntk148v/vim-horizon'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot'
Plug 'mattn/vim-goimports'
Plug 'nvim-lua/plenary.nvim'
Plug 'ayu-theme/ayu-vim'
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css',
	\         'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml',
	\ 'html'] }
Plug 'alvan/vim-closetag'
Plug 'rust-lang/rust.vim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'neovim/nvim-lspconfig'
Plug 'nvimdev/dashboard-nvim'
call plug#end()

runtime ./src/command.vim
runtime ./src/func.vim
runtime ./src/let.vim
runtime ./src/lua.vim

" 一時的な処理
lua << EOF
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
EOF
