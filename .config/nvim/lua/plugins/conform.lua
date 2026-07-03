-- Formatting (stevearc/conform.nvim)
-- Unifies format-on-save. Prettier for web languages (respects .prettierrc,
-- uses the project-local prettier if present); other filetypes fall back to
-- the attached LSP (e.g. rust_analyzer -> rustfmt).
-- Go is intentionally left to vim-goimports, so it is skipped here.

local status, conform = pcall(require, "conform")
if not status then
    return
end

conform.setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        vue = { "prettier" },
        svelte = { "prettier" },
    },
    format_on_save = function(bufnr)
        -- Let vim-goimports keep handling Go
        if vim.bo[bufnr].filetype == "go" then
            return
        end
        return { timeout_ms = 1500, lsp_format = "fallback" }
    end,
})

-- Manual format mapping
vim.keymap.set({ "n", "v" }, "<leader>F", function()
    conform.format({ async = true, lsp_format = "fallback" })
end, { silent = true, desc = "Format buffer" })
