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

