-- Copilot configuration

local function setup_copilot()
    -- Global Copilot settings
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    vim.g.copilot_filetypes = {
        ["*"] = false,
        ["javascript"] = true,
        ["typescript"] = true,
        ["lua"] = true,
        ["rust"] = true,
        ["c"] = true,
        ["cpp"] = true,
        ["go"] = true,
        ["python"] = true,
        ["sh"] = true,
        ["zsh"] = true,
        ["bash"] = true,
        ["html"] = true,
        ["css"] = true,
        ["scss"] = true,
        ["json"] = true,
        ["yaml"] = true,
        ["markdown"] = true,
        ["gitcommit"] = true,
    }
    
    -- Key mappings for Copilot
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Dismiss()', { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Next()', { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Previous()', { expr = true, silent = true })
    
    -- Additional settings for better integration
    vim.g.copilot_enabled = 1
    vim.g.copilot_highlight_color = "#6e7681"
end

-- Setup Copilot when the plugin is loaded
vim.api.nvim_create_autocmd("User", {
    pattern = "CopilotSetup",
    callback = setup_copilot,
})

-- Also setup immediately if Copilot is already available
if vim.fn.exists('*copilot#Accept') == 2 then
    setup_copilot()
end

return {
    setup = setup_copilot
} 