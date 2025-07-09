-- Silence plugin warnings and messages

-- Disable which-key warnings
vim.api.nvim_create_autocmd("User", {
    pattern = "WhichKey",
    callback = function()
        -- Suppress which-key warnings
        vim.g.which_key_suppress_warnings = true
    end,
})

-- Disable LSP warnings
vim.api.nvim_create_autocmd("User", {
    pattern = "LspAttached",
    callback = function()
        -- Suppress LSP warnings
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
            }
        )
    end,
})

-- Disable Treesitter warnings
vim.api.nvim_create_autocmd("User", {
    pattern = "TreesitterSetup",
    callback = function()
        -- Suppress Treesitter warnings
        vim.g.treesitter_suppress_warnings = true
    end,
})

-- Disable Telescope warnings
vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopeSetup",
    callback = function()
        -- Suppress Telescope warnings
        vim.g.telescope_suppress_warnings = true
    end,
})

-- Disable general plugin warnings
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Suppress general warnings
        vim.g.suppress_warnings = true
    end,
}) 