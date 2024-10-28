lua << EOF
require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",
      "target/debug"
    }
  }
}

require'lspconfig'.ts_ls.setup{}

local status, bufferline = pcall(require, "bufferline")
if not status then return end

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

bufferline.setup{}
EOF

