-- Neovim Configuration
-- Entry point for all configuration

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd('language messages en_US.UTF-8')
-- Add lazy.nvim path to runtimepath
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lazy/lazy.nvim")

-- Plugin management with lazy.nvim
require("lazy").setup({
  { "voldikss/vim-floaterm" },
  { "rking/ag.vim" },
  { "ntk148v/vim-horizon" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end },
  { "sheerun/vim-polyglot" },
  { "mattn/vim-goimports" },
  { "nvim-lua/plenary.nvim" },
  { "prettier/vim-prettier", build = "yarn install", ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "svelte", "yaml", "html" } },
  { "alvan/vim-closetag" },
  { "rust-lang/rust.vim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
  { "neoclide/coc.nvim", branch = "release", lazy = false },
  { "fatih/vim-go", build = ":GoUpdateBinaries" },
  { "ryanoasis/vim-devicons" },
  { "tpope/vim-fugitive" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  { "pangloss/vim-javascript" },
  { "leafgarland/typescript-vim" },
  { "maxmellon/vim-jsx-pretty" },
  { "jparise/vim-graphql" },
  { "neovim/nvim-lspconfig" },
  { "nvimdev/dashboard-nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
})

-- Load core configuration
require("core")
-- Load plugins (settings only)
require("plugins")
-- Load utilities
require("utils")
-- Load autocmd
require("autocmds") 
