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

-- Auto format on save for TypeScript/JavaScript files
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
    callback = function()
        -- Try LSP formatting first
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        local has_formatter = false
        
        for _, client in ipairs(clients) do
            if client.server_capabilities.documentFormattingProvider then
                has_formatter = true
                break
            end
        end
        
        if has_formatter then
            vim.lsp.buf.format({ async = false })
        else
            -- Fallback to Prettier if LSP formatter is not available
            vim.cmd("Prettier")
        end
    end,
})

-- Copilot key mappings
vim.api.nvim_create_autocmd("User", {
    pattern = "CopilotSetup",
    callback = function()
        -- Ensure Copilot key mappings work correctly
        vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Dismiss()', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Next()', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Previous()', { expr = true, silent = true })
    end,
})

-- Input functions (using utils.functions module)
local func = require('utils.functions')

vim.keymap.set("i", "{", function() return func.input_parentheses("{") end, { expr = true })
vim.keymap.set("i", "[", function() return func.input_parentheses("[") end, { expr = true })
vim.keymap.set("i", "(", function() return func.input_parentheses("(") end, { expr = true })

vim.keymap.set("i", "}", function() return func.input_close_parenthesis("}") end, { expr = true })
vim.keymap.set("i", "]", function() return func.input_close_parenthesis("]") end, { expr = true })
vim.keymap.set("i", ")", function() return func.input_close_parenthesis(")") end, { expr = true })

vim.keymap.set("i", "'", function() return func.input_quot("'") end, { expr = true })
vim.keymap.set("i", "\"", function() return func.input_quot("\"") end, { expr = true })
vim.keymap.set("i", "`", function() return func.input_quot("`") end, { expr = true })

-- Removed conflicting Enter key mappings
vim.keymap.set("i", "<Space>", function() return func.input_space() end, { expr = true })
vim.keymap.set("i", "<BS>", function() return func.input_bs() end, { expr = true })

-- Visual mode mappings
vim.keymap.set("x", "{", function() return func.clip_in_parentheses("{") end, { expr = true })
vim.keymap.set("x", "[", function() return func.clip_in_parentheses("[") end, { expr = true })
vim.keymap.set("x", "(", function() return func.clip_in_parentheses("(") end, { expr = true })

vim.keymap.set("x", "'", function() return func.clip_in_quot("'") end, { expr = true })
vim.keymap.set("x", "\"", function() return func.clip_in_quot("\"") end, { expr = true })
vim.keymap.set("x", "`", function() return func.clip_in_quot("`") end, { expr = true }) 
