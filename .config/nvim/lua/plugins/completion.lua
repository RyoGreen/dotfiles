local M = {}

function M.setup()
    -- Basic LSP completion settings
    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"

    -- Enable LSP completion
    vim.opt.completeopt = "menu,menuone,noselect"

    -- Completion menu/keys are owned by nvim-cmp (see init.lua)
end

return M 
