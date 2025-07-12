local M = {}

function M.setup()
    -- Basic LSP completion settings
    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"

    -- Enable LSP completion
    vim.opt.completeopt = "menu,menuone,noselect"

    -- Simple completion key mappings
    -- Use default Neovim completion behavior
    vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", {silent = true, noremap = true})
    
    -- Tab and Enter work normally
    -- LSP completion will trigger automatically when typing
end

return M 
