-- Telescope configuration
local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "%target/",
      "%.git/",
      "dist/",
      ".next/",
    },

    border = true,

    layout_config = {
      width = 0.75,
    },

    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-c>"] = actions.close,
      },
      n = {
        ["<Esc>"] = actions.close,
      },
    },
  },

  previewer = false,
  pickers = {
    find_files = {
      hidden = true,
      previewer = false,
      no_ignore = true,
    },
    live_grep = {
      previewer = true,
    }
  },
})
