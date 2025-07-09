-- Telescope configuration

local status, telescope = pcall(require, "telescope")
if not status then
    return
end

telescope.setup{ 
    defaults = { 
        file_ignore_patterns = { "node_modules", "target/debug" },
        preview = false,
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        mappings = {
            i = { ["<C-f>"] = require('telescope.actions').close },
            n = { ["<C-f>"] = require('telescope.actions').close }
        }
    },
    pickers = {
        find_files = {
            border = true,
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        live_grep = {
            border = true,
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        buffers = {
            border = true,
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
    }
} 
