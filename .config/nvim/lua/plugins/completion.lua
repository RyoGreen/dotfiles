-- Minimal COC configuration for completion only
-- Enter: 補完を確定
-- Tab: 次の候補に移動  
-- Shift+Tab: 前の候補に移動

local M = {}

function M.setup()
    -- Basic COC settings
    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"

    local keyset = vim.keymap.set
    
    -- Autocomplete function
    function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- Completion keymaps
    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    
    keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    
    keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    
    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
end

return M 
