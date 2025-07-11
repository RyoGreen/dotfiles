-- LSP configuration

local status, lspconfig = pcall(require, "lspconfig")
if not status then
    return
end

-- LSP key mappings
local function setup_lsp_keymaps(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    
    -- Definition jumping
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    
    -- Workspace
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
    
    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
end

-- LSP on_attach function
local function on_attach(client, bufnr)
    setup_lsp_keymaps(client, bufnr)
    
    -- Set buffer options
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    -- Highlight references
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
        vim.api.nvim_create_autocmd('CursorHold', {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = 'lsp_document_highlight'
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = 'lsp_document_highlight'
        })
    end
end

-- Go LSP configuration
lspconfig.gopls.setup({
    on_attach = on_attach,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
    flags = {
        debounce_text_changes = 150,
    },
})

-- TypeScript/JavaScript LSP configuration
lspconfig.tsserver.setup({
    on_attach = on_attach,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
    flags = {
        debounce_text_changes = 150,
    },
})

-- Rust LSP configuration
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = { granularity = { group = "module" }, prefix = "crate" },
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
            inlayHints = {
                typeHints = true,
                parameterHints = true,
                chainingHints = true,
            },
        },
    },
})

-- LSP diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Temporary LSP diagnostic handler fix
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_handler = vim.lsp.handlers[method]

  vim.lsp.handlers[method] = function(err, result, ctx, config)
    if err then
      if err.code == -32802 then
        vim.notify(
          string.format("LSP [%s] returned temporary error (-32802): %s", method, err.message),
          vim.log.levels.WARN,
          { title = "LSP Diagnostic" }
        )
        return
      else
        vim.notify(
          string.format("LSP [%s] error (%d): %s", method, err.code or -1, err.message),
          vim.log.levels.ERROR,
          { title = "LSP Diagnostic" }
        )
      end
    end

    return default_handler(err, result, ctx, config)
  end
end

