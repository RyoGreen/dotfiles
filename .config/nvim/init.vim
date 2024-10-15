let $LANG='en_US.UTF-8'

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
call plug#end()

runtime ./src/command.vim
runtime ./src/func.vim
runtime ./src/let.vim
runtime ./src/lua.vim
