-- Autocommands configuration

-- File type associations
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.tpl",
    command = "set filetype=html",
})

vim.api.nvim_create_autocmd("StdinReadPre", {
    callback = function()
        vim.g.std_in = 1
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "scss",
    command = "setlocal iskeyword+=@-@",
})

-- Formatting on save is handled by conform.nvim (see plugins/conform.lua)

-- Input functions (using utils.functions module)
-- NOTE: insert-mode auto-pairing is handled by nvim-autopairs; only the
-- visual-mode "wrap selection" helpers below use these custom functions.
local func = require('utils.functions')

-- Visual mode mappings
vim.keymap.set("x", "{", function() return func.clip_in_parentheses("{") end, { expr = true })
vim.keymap.set("x", "[", function() return func.clip_in_parentheses("[") end, { expr = true })
vim.keymap.set("x", "(", function() return func.clip_in_parentheses("(") end, { expr = true })

vim.keymap.set("x", "'", function() return func.clip_in_quot("'") end, { expr = true })
vim.keymap.set("x", "\"", function() return func.clip_in_quot("\"") end, { expr = true })
vim.keymap.set("x", "`", function() return func.clip_in_quot("`") end, { expr = true })
