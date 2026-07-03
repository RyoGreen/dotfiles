-- LSP server management (mason.nvim + mason-lspconfig.nvim)
-- Installs the servers; enabling is handled explicitly in plugins/lsp.lua
-- via vim.lsp.enable(), so automatic_enable is turned off to avoid duplication.

local status, mason = pcall(require, "mason")
if not status then
    return
end

mason.setup()

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok then
    mason_lspconfig.setup({
        ensure_installed = { "gopls", "rust_analyzer", "ts_ls" },
        automatic_enable = false,
    })
end
