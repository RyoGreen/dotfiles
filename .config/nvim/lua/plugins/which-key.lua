-- Keymap popup helper (folke/which-key.nvim)

local status, wk = pcall(require, "which-key")
if not status then
    return
end

wk.setup({})

-- Group labels for the leader-based mappings used in this config
wk.add({
    { "<leader>h", group = "git hunk" },
    { "<leader>l", group = "lsp symbols" },
    { "<leader>w", group = "workspace" },
    { "<leader>x", group = "diagnostics" },
    { "<leader>g", group = "git" },
})
