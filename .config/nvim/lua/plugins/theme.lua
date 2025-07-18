-- Theme configuration

-- Tokyo Night theme setup
local status, tokyonight = pcall(require, "tokyonight")
if status then
    tokyonight.setup({
        style = "moon",
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help", "terminal", "NvimTree", "TelescopePrompt", "TelescopeResults", "Trouble" },
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
    })
    vim.cmd([[colorscheme tokyonight]])
else
    vim.cmd([[colorscheme desert]])
    vim.api.nvim_echo({{"Tokyo Night theme not found. Using fallback theme.", "WarningMsg"}}, true, {})
end 
