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
    
    -- Additional settings for better integration
    vim.g.copilot_enabled = 1
    vim.g.copilot_highlight_color = "#6e7681"
    
    -- Key mappings for Copilot - using different approach
    vim.keymap.set("i", "<C-l>", function()
        return vim.fn["copilot#Accept"]("<CR>")
    end, { expr = true, silent = true })
    
    vim.keymap.set("i", "<C-c>", function()
        return vim.fn["copilot#Dismiss"]()
    end, { expr = true, silent = true })
    
    vim.keymap.set("i", "<C-j>", function()
        return vim.fn["copilot#Next"]()
    end, { expr = true, silent = true })
    
    vim.keymap.set("i", "<C-k>", function()
        return vim.fn["copilot#Previous"]()
    end, { expr = true, silent = true })
    
    print("Copilot key mappings set up successfully")
end

-- Debug command to check Copilot status
vim.api.nvim_create_user_command('CopilotDebug', function()
    print("Copilot function exists:", vim.fn.exists('*copilot#Accept'))
    print("Copilot enabled:", vim.g.copilot_enabled)
    print("Copilot no tab map:", vim.g.copilot_no_tab_map)
    print("Copilot assume mapped:", vim.g.copilot_assume_mapped)
    
    -- Check if key mappings are set
    local keymap = vim.api.nvim_get_keymap('i')
    for _, map in ipairs(keymap) do
        if map.lhs == '<C-l>' then
            print("Ctrl+L mapping found:", vim.inspect(map))
        end
    end
end, {})

-- Setup Copilot when the plugin is loaded
vim.api.nvim_create_autocmd("User", {
    pattern = "CopilotSetup",
    callback = setup_copilot,
})

-- Also setup immediately if Copilot is already available
if vim.fn.exists('*copilot#Accept') == 2 then
    setup_copilot()
end

-- Alternative setup using VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Wait a bit for plugins to load
        vim.defer_fn(function()
            if vim.fn.exists('*copilot#Accept') == 2 then
                setup_copilot()
            end
        end, 100)
    end,
})

return {
    setup = setup_copilot
} 