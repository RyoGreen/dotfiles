-- LSP configuration

local status, lspconfig = pcall(require, "lspconfig")
if not status then
    return
end

-- LSP configurations
lspconfig.ts_ls.setup{}
lspconfig.rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] = {
            imports = { granularity = { group = "module" }, prefix = "crate" },
            cargo = { allFeatures = true },
            -- checkOnSave = { command = "clippy" },
        },
    },
}

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
