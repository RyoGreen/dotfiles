-- Editing productivity plugins configuration

-- nvim-autopairs (Auto pair completion)
local status, autopairs = pcall(require, "nvim-autopairs")
if status then
    autopairs.setup({
        check_ts = true,
        ts_config = {
            lua = { "string" },
            javascript = { "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    })
end

-- Comment.nvim (Smart comment operations)
local status, comment = pcall(require, "Comment")
if status then
    comment.setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = "gcc",
            block = "gbc",
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
        extra = {
            above = "gcO",
            below = "gco",
            eol = "gcA",
        },
        mappings = {
            basic = true,
            extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
    })
end

-- nvim-surround (Surround operations)
local status, surround = pcall(require, "nvim-surround")
if status then
    surround.setup({
        keymaps = {
            insert = "<C-g>s",
            insert_line = "<C-g>S",
            normal = "ys",
            normal_cur = "yss",
            normal_line = "yS",
            normal_cur_line = "ySS",
            visual = "S",
            visual_line = "gS",
            delete = "ds",
            change = "cs",
        },
        aliases = {
            ["a"] = ">",
            ["b"] = ")",
            ["B"] = "}",
            ["r"] = "]",
            ["q"] = { '"', "'", "`" },
            ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        },
        highlight = {
            duration = 0,
        },
    })
end

-- indent-blankline.nvim (Indent guides) - v3 compatible
local status, ibl = pcall(require, "ibl")
if status then
    ibl.setup({
        indent = { char = "│" },
        scope = { enabled = true, show_start = true, show_end = false },
        exclude = {
            buftypes = { "terminal", "nofile" },
            filetypes = {
                "help", "startify", "dashboard", "packer", "neogitstatus",
                "NvimTree", "Trouble", "text"
            },
        },
    })
end

-- treesitter-context (Show current context)
local status, treesitter_context = pcall(require, "treesitter-context")
if status then
    treesitter_context.setup({
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
            default = {
                "class",
                "function",
                "method",
                "for",
                "while",
                "if",
                "switch",
                "case",
            },
        },
    })
end

-- undotree (Undo history)
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true })

-- Auto-save functionality
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
            vim.cmd("silent! write")
        end
    end,
})

-- Quick save mapping
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<C-c>:w<CR>", { silent = true })

 
