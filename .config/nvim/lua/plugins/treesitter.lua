-- Treesitter configuration

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "rust",
        "go",
        "python",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}) 