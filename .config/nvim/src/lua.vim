lua << EOF
require('dashboard').setup {
  theme = 'hyper',
  config = {
   header = {
      ' ██████╗██╗  ██╗██╗ ██████╗  █████╗  ██████╗       ██████╗ ██╗   ██╗██╗     ██╗███████╗',
      '██╔════╝██║  ██║██║██╔════╝ ██╔══██╗██╔═══██╗      ██╔══██╗██║   ██║██║     ██║██╔════╝',
      '██║     ███████║██║██║  ███╗███████║██║   ██║█████╗██████╔╝██║   ██║██║     ██║█████╗  ',
      '██║     ██╔══██║██║██║   ██║██╔══██║██║   ██║╚════╝██╔═══╝ ██║   ██║██║     ██║██╔══╝  ',
      '╚██████╗██║  ██║██║╚██████╔╝██║  ██║╚██████╔╝      ██║     ╚██████╔╝███████╗██║██║     ',
      ' ╚═════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝       ╚═╝      ╚═════╝ ╚══════╝╚═╝╚═╝     ',
      '',
   },
	center = {
      {
        icon = '  ', 
        desc = 'Find File                 ',  
        action = 'Telescope find_files',  
        shortcut = 'SPC f f' 
      },
      {
        icon = '  ',
        desc = 'Find Word                 ',
        action = 'Telescope live_grep',
        shortcut = 'SPC f w'
      },
      {
        icon = '  ',
        desc = 'Recent Files              ',
        action = 'Telescope oldfiles',
        shortcut = 'SPC f r'
      },
      {
        icon = '  ',
        desc = 'Open GitHub Repo          ',
        action = 'lua require("custom").open_github()',
        shortcut = 'SPC g o'
      },
      {
        icon = '⚙️ ',
        desc = 'Open Settings             ',
        action = ':e ~/.config/nvim/init.lua',
        shortcut = 'SPC s e'
      },
    },
  }
}

require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",
      "target/debug"
    }
  }
}

require'lspconfig'.ts_ls.setup{}
require('lspconfig').rust_analyzer.setup{
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "crate"
      },
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
local status, bufferline = pcall(require, "bufferline")
if not status then return end

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
vim.keymap.set('n', 'sd', function()
  vim.cmd('bufdo bd')
  vim.cmd('Dashboard')
end, { silent = true })
bufferline.setup{}

require('telescope').setup{
  defaults = {
    preview = false,
    mappings = {
      i = {
        ["<C-f>"] = require('telescope.actions').close 
      },
      n = {
        ["<C-f>"] = require('telescope.actions').close 
      }
    }
  }
}

EOF
