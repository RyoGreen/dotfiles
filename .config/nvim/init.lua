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
  -- { "fatih/vim-go", build = ":GoUpdateBinaries" }, -- Disabled to use pure LSP
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

  -- nvim-cmp & dependencies
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },

  -- nvim-autopairs for automatic bracket pairing
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = {'string'},-- it will not add a pair on that treesitter node
          javascript = {'template_string'},
          java = false,-- don't check treesitter on java
        }
      })
      
      -- Integrate with nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    end
  },

  -- nvim-ts-autotag for automatic HTML/JSX tag closing
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
})

-- Load core configuration
require("core")
-- Load plugins (settings only)
require("plugins")
-- Load utilities
require("utils")
-- Load autocmds
require("autocmds") 
