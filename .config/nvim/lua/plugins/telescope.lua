-- Telescope configuration

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",

  opts = function()
    local actions = require("telescope.actions")

    return {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "target/debug",
          "%.git/",
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

      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }
  end,
}

