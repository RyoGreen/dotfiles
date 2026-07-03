-- Neovim Configuration
-- Entry point for all configuration

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("language messages en_US.UTF-8")

-- Add lazy.nvim path to runtimepath
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lazy/lazy.nvim")

-- Plugin management with lazy.nvim
require("lazy").setup({
  { "voldikss/vim-floaterm" },
  { "rking/ag.vim" },
  { "ntk148v/vim-horizon" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  { "sheerun/vim-polyglot" },
  { "mattn/vim-goimports" },
  { "nvim-lua/plenary.nvim" },
  {
    "prettier/vim-prettier",
    build = "yarn install",
    ft = {
      "javascript",
      "typescript",
      "css",
      "less",
      "scss",
      "json",
      "graphql",
      "markdown",
      "vue",
      "svelte",
      "yaml",
      "html",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  { "rust-lang/rust.vim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.4" },

  -- { "fatih/vim-go", build = ":GoUpdateBinaries" },
  { "ryanoasis/vim-devicons" },
  { "tpope/vim-fugitive" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  { "pangloss/vim-javascript" },
  { "leafgarland/typescript-vim" },
  { "maxmellon/vim-jsx-pretty" },
  { "jparise/vim-graphql" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            completion = {
              callable = {
                snippets = "none",
              },
            },
          },
        },
      })
    end,
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "nvim-lualine/lualine.nvim",       dependencies = "nvim-tree/nvim-web-devicons" },
  { "lewis6991/gitsigns.nvim" },
  { "folke/which-key.nvim",            event = "VeryLazy" },
  { "stevearc/conform.nvim" },
  { "folke/trouble.nvim",              dependencies = "nvim-tree/nvim-web-devicons" },
  { "nvimdev/dashboard-nvim" },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      vim.keymap.set(
        "i",
        "<C-l>",
        'copilot#Accept("")',
        { expr = true, silent = true, replace_keycodes = false }
      )

      vim.keymap.set(
        "i",
        "<C-c>",
        "copilot#Dismiss()",
        { expr = true, silent = true }
      )
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
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
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- nvim-autopairs for automatic bracket pairing
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

      local cmp_autopairs =
        require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          map_char = { tex = "" },
        })
      )
    end,
  },

  -- nvim-ts-autotag for automatic HTML/JSX tag closing
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
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
