-- indent-blankline / ibl configuration
local status_ok, ibl = pcall(require, "ibl")
if not status_ok then return end

ibl.setup({
  indent = { char = "▏", tab_char = "▏" },
  scope = { enabled = true, show_start = false, show_end = false },
  exclude = {
    filetypes = { "help", "dashboard", "lazy", "mason", "NvimTree", "TelescopePrompt", "TelescopeResults" },
  },
})
