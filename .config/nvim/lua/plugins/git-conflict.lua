-- git-conflict.nvim configuration
local status_ok, conflict = pcall(require, "git-conflict")
if not status_ok then return end

conflict.setup({
  default_mappings = true,
  disable_diagnostics = true,
  highlights = {
    incoming = "DiffAdd",
    current  = "DiffText",
    ancestor = "DiffChange",
  },
})
