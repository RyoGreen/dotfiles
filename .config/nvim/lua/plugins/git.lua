-- Git productivity plugins configuration

-- gitsigns.nvim (Git diff indicators)
local status, gitsigns = pcall(require, "gitsigns")
if status then
    gitsigns.setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
    })
end

-- trouble.nvim (Diagnostics and references display)
local status, trouble = pcall(require, "trouble")
if status then
    trouble.setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        severity = nil,
        fold_open = " ",
        fold_closed = " ",
        group = true,
        padding = true,
        cycle_results = true,
        action_keys = {
            close = "q",
            cancel = "<esc>",
            refresh = "r",
            jump = { "<cr>", "<tab>" },
            open_in_browser = "gx",
            copy_to_clipboard = "<C-c>",
            toggle_preview = "P",
            hover = "K",
            preview = "p",
            close_folds = { "zM", "zm" },
            open_folds = { "zR", "zr" },
            toggle_fold = { "zA", "za" },
            previous = "k",
            next = "j",
            help = "?",
        },
        multiline = true,
        indent_lines = true,
        win_config = { border = "single" },
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions", "lsp_references" },
        include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" },
        cycle_results = true,
    })
end



-- Git key mappings
local map = vim.keymap.set
local opts = { silent = true }

-- Trouble mappings
map("n", "<leader>xx", function() trouble.toggle() end, opts)
map("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end, opts)
map("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end, opts)
map("n", "<leader>xq", function() trouble.toggle("quickfix") end, opts)
map("n", "<leader>xl", function() trouble.toggle("loclist") end, opts)
map("n", "gR", function() trouble.toggle("lsp_references") end, opts)

-- Git operations
map("n", "<leader>gs", ":Git status<CR>", opts)
map("n", "<leader>gc", ":Git commit<CR>", opts)
map("n", "<leader>gp", ":Git push<CR>", opts)
map("n", "<leader>gl", ":Git log<CR>", opts)
map("n", "<leader>gd", ":Git diff<CR>", opts)
map("n", "<leader>gb", ":Git blame<CR>", opts)

-- Git signs navigation
map("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(function() gitsigns.next_hunk() end)
    return "<Ignore>"
end, { expr = true, silent = true })

map("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(function() gitsigns.prev_hunk() end)
    return "<Ignore>"
end, { expr = true, silent = true })

-- Git signs actions
map("n", "<leader>hs", gitsigns.stage_hunk, opts)
map("n", "<leader>hr", gitsigns.reset_hunk, opts)
map("v", "<leader>hs", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, opts)
map("v", "<leader>hr", function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, opts)
map("n", "<leader>hS", gitsigns.stage_buffer, opts)
map("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
map("n", "<leader>hR", gitsigns.reset_buffer, opts)
map("n", "<leader>hp", gitsigns.preview_hunk, opts)
map("n", "<leader>hb", function() gitsigns.blame_line{full=true} end, opts)
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)
map("n", "<leader>hd", gitsigns.diffthis, opts)
map("n", "<leader>hD", function() gitsigns.diffthis("~") end, opts)
map("n", "<leader>td", gitsigns.toggle_deleted, opts) 
