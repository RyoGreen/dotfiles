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

bufferline.setup{}
EOF

