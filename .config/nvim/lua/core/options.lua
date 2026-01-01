-- Neovim options configuration

-- Basic settings
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Shell
vim.opt.shell = "/bin/zsh"

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true

-- Text formatting
vim.opt.textwidth = 0
vim.opt.encoding = "UTF-8"

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Behavior
vim.opt.clipboard = "unnamed"
vim.opt.confirm = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Performance
vim.opt.lazyredraw = true
vim.opt.updatetime = 300
