-- LSP configuration

vim.lsp.enable('gopls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('tsserver')

-- LSP key mappings (COC-style)
local function setup_lsp_keymaps(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    
    -- COC-style key mappings
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)      -- Definition jump
    vim.keymap.set('n', 'gd', vim.lsp.buf.implementation, opts)     -- Implementation jump
    vim.keymap.set('n', 'cr', vim.lsp.buf.references, opts)         -- References
    vim.keymap.set('n', '<C-t>', '<C-o>', opts)                     -- Jump back
    
    -- Additional LSP mappings
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
end

-- LSP on_attach function
local function on_attach(client, bufnr)
    setup_lsp_keymaps(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    print(string.format("LSP client '%s' attached to buffer %d with COC-style keymaps", client.name, bufnr))
end

-- Diagnostic config
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Debug commands for LSP
vim.api.nvim_create_user_command('LspDebug', function()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if #clients == 0 then
        print("No LSP clients attached to current buffer")
    else
        for _, client in ipairs(clients) do
            print(string.format("LSP Client: %s (id: %d)", client.name, client.id))
            print(string.format("  Root: %s", client.config.root_dir or "nil"))
            print(string.format("  Capabilities: %s", vim.inspect(client.server_capabilities)))
        end
    end
end, {})

vim.api.nvim_create_user_command('LspRestart', function()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
    end
    vim.cmd('LspStart')
end, {})

-- Note: vim.lsp.enable() automatically handles LSP server startup
-- No need for manual autocmd triggers

-- Temporary LSP diagnostic handler fix
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

