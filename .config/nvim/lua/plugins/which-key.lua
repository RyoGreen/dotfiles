-- which-key.nvim configuration
local status, which_key = pcall(require, "which-key")
if not status then
    return
end

-- Setup which-key with minimal configuration
which_key.setup({
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 20,
        },
    },
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
    win = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    show_help = true,
    show_keys = true,
    triggers = { "<leader>" },
    disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
    },
    -- Disable warnings
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
})

-- Register key mappings with proper format
-- Register groups with their actual key prefixes
which_key.register({
    { "<leader>b", group = "Buffer" },
    { "<leader>c", group = "Change" },
    { "<leader>e", group = "Explorer" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Git Hunk" },
    { "<leader>n", group = "Navigation" },
    { "<leader>r", group = "Refresh" },
    { "<leader>t", group = "Tab" },
    { "<leader>u", group = "Undo" },
    { "<leader>x", group = "Trouble" },
}) 
