-- Enhanced navigation configuration with Telescope and file browser

-- Telescope configuration
local status, telescope = pcall(require, "telescope")
if status then
    telescope.setup({
        defaults = {
            file_ignore_patterns = { 
                "node_modules", "target/debug", ".git", "dist", "build",
                "*.pyc", "__pycache__", ".DS_Store"
            },
            preview = true,
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    preview_width = 0.6,
                    results_width = 0.4,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            mappings = {
                i = {
                    ["<C-f>"] = require('telescope.actions').close,
                    ["<C-j>"] = require('telescope.actions').move_selection_next,
                    ["<C-k>"] = require('telescope.actions').move_selection_previous,
                    ["<C-n>"] = require('telescope.actions').cycle_history_next,
                    ["<C-p>"] = require('telescope.actions').cycle_history_prev,
                },
                n = {
                    ["<C-f>"] = require('telescope.actions').close,
                    ["<C-j>"] = require('telescope.actions').move_selection_next,
                    ["<C-k>"] = require('telescope.actions').move_selection_previous,
                },
            },
        },
        pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
            live_grep = {
                additional_args = function()
                    return {"--hidden", "--glob", "!**/.git/*"}
                end,
            },
        },
        extensions = {
            file_browser = {
                theme = "dropdown",
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        ["<C-w>"] = function() vim.cmd('normal vbd') end,
                    },
                    ["n"] = {
                        ["N"] = require("telescope").extensions.file_browser.actions.create,
                        ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                        ["/"] = function()
                            vim.cmd('startinsert')
                        end,
                    },
                },
            },
        },
    })
end

-- Load Telescope extensions
pcall(require('telescope').load_extension, 'file_browser')

-- Enhanced key mappings for navigation
local map = vim.keymap.set
local opts = { silent = true }

-- Telescope mappings
map("n", "<leader>ff", function()
    require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))
end, opts)

map("n", "<leader>fg", function()
    require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))
end, opts)

map("n", "<leader>fb", function()
    require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))
end, opts)

map("n", "<leader>fh", function()
    require("telescope.builtin").help_tags(require("telescope.themes").get_dropdown({}))
end, opts)

map("n", "<leader>fo", function()
    require("telescope.builtin").oldfiles(require("telescope.themes").get_dropdown({}))
end, opts)

map("n", "<leader>fe", function()
    require("telescope").extensions.file_browser.file_browser(require("telescope.themes").get_dropdown({}))
end, opts)

-- Quick navigation
map("n", "<leader>cd", function()
    vim.cmd("cd " .. vim.fn.expand("%:p:h"))
    print("Changed directory to: " .. vim.fn.getcwd())
end, opts)

-- Buffer navigation
map("n", "<leader>bn", ":bn<CR>", opts)
map("n", "<leader>bp", ":bp<CR>", opts)
map("n", "<leader>bd", ":bd<CR>", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
map("n", "<leader>tn", ":tabnew<CR>", opts)
map("n", "<leader>tc", ":tabclose<CR>", opts)
map("n", "<leader>to", ":tabonly<CR>", opts)
map("n", "<leader>th", ":tabprev<CR>", opts)
map("n", "<leader>tl", ":tabnext<CR>", opts)

-- Quick file operations
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>f", ":NvimTreeFindFile<CR>", opts)

 