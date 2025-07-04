lua << EOF

-- Dashboard settings
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
      { icon = '  ', desc = 'Find File                 ', action = 'Telescope find_files', shortcut = 'SPC f f' },
      { icon = '  ', desc = 'Find Word                 ', action = 'Telescope live_grep', shortcut = 'SPC f w' },
      { icon = '  ', desc = 'Recent Files              ', action = 'Telescope oldfiles', shortcut = 'SPC f r' },
      { icon = '  ', desc = 'Open GitHub Repo          ', action = 'lua require("custom").open_github()', shortcut = 'SPC g o' },
      { icon = '⚙️ ', desc = 'Open Settings             ', action = ':e ~/.config/nvim/init.lua', shortcut = 'SPC s e' },
    },
  }
}

-- Telescope settings
require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { "node_modules", "target/debug", "dist" },
    preview = false,
    mappings = {
      i = { ["<C-f>"] = require('telescope.actions').close },
      n = { ["<C-f>"] = require('telescope.actions').close }
    }
  }
}

-- LSP configurations
require('lspconfig').ts_ls.setup{}
require('lspconfig').rust_analyzer.setup{
  settings = {
    ["rust-analyzer"] = {
      imports = { granularity = { group = "module" }, prefix = "crate" },
      cargo = { allFeatures = true },
      -- checkOnSave = { command = "clippy" },
    },
  },
}

-- Key mappings for bufferline
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

-- Key mapping to close all buffers and show Dashboard
vim.keymap.set('n', 'sd', function()
  vim.cmd('bufdo bd')
  vim.cmd('Dashboard')
end, { silent = true })

-- Bufferline settings
local status, bufferline = pcall(require, "bufferline")
if status then
  bufferline.setup{
    options = {
      mode = "buffers",
      separator_style = "slant",
      always_show_bufferline = true,
      offsets = {
        { filetype = "NvimTree", text = "File Explorer", text_align = "center", padding = 1 }
      },
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      color_icons = true,
      show_tab_indicators = true,
    },
    highlights = {
	  fill = { bg = "#2e3440" },
      background = { fg = "#666666", bg = "#1e1e2e" },
      buffer_selected = { fg = "#f8f8f2", bold = true, italic = false },
      separator = { fg = "#44475a", bg = "#1e1e2e" },
      separator_selected = { fg = "#f8f8f2", bg = "#1e1e2e" },
      modified = { fg = "#bd93f9" },
      modified_selected = { fg = "#ff79c6" },
    }
  }
end

require("tokyonight").setup({
  style = "night",  -- スタイルを指定（night, storm など）
  transparent = true,
  styles = {
    comments = { italic = true },  -- コメントは斜体にする
  },
  on_highlights = function(highlights, colors)
    -- コメントを蛍光グリーンに変更
    highlights.Comment = { fg = "#00FF00", italic = true }

    -- その他のカスタマイズ（赤・紫を抑える）
    highlights.Keyword = { fg = colors.blue }
    highlights.Statement = { fg = colors.blue }
    highlights.DiagnosticError = { fg = colors.blue }
    highlights.DiagnosticWarn = { fg = colors.cyan }
  end,
})

require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
      },
    },
  },
})
EOF
