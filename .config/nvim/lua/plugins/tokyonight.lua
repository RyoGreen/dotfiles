-- Tokyo Night theme configuration
-- A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins

local M = {}

function M.setup()
    require("tokyonight").setup({
        -- Main options --
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark", -- style for sidebars, see below
            floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help", "terminal", "NvimTree", "TelescopePrompt", "TelescopeResults" }, -- Set a darker background on sidebar-like windows
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
            -- colors.hint = colors.orange1
            -- colors.error = colors.red1
        end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors)
            -- highlights.Comment = { fg = colors.gray2, italic = true }
            -- highlights.LineNr = { fg = colors.gray4 }
            -- highlights.CursorLineNr = { fg = colors.magenta2 }
            
            -- Telescope border colors - force all borders to be blue
            local border_color = colors.blue1
            highlights.TelescopeBorder = { fg = border_color, bg = colors.bg }
            highlights.TelescopeSelectionCaret = { fg = border_color, bg = colors.bg }
            highlights.TelescopeSelection = { fg = colors.fg, bg = colors.bg_highlight }
            highlights.TelescopeMatching = { fg = colors.orange1 }
            highlights.TelescopePromptPrefix = { fg = colors.blue1 }
            highlights.TelescopePromptNormal = { bg = colors.bg, border = { fg = border_color } }
            highlights.TelescopeResultsNormal = { bg = colors.bg, border = { fg = border_color } }
            highlights.TelescopePreviewNormal = { bg = colors.bg, border = { fg = border_color } }
            highlights.TelescopePromptBorder = { fg = border_color, bg = colors.bg }
            highlights.TelescopeResultsBorder = { fg = border_color, bg = colors.bg }
            highlights.TelescopePreviewBorder = { fg = border_color, bg = colors.bg }
            -- Force all telescope borders to be blue
            highlights.TelescopeTitle = { fg = border_color, bg = colors.bg }
            highlights.TelescopePromptTitle = { fg = border_color, bg = colors.bg }
            highlights.TelescopeResultsTitle = { fg = border_color, bg = colors.bg }
            highlights.TelescopePreviewTitle = { fg = border_color, bg = colors.bg }
        end,
    })

    -- Set the theme
    vim.cmd([[colorscheme tokyonight]])
    
    -- Force telescope borders to be blue after theme is loaded
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
            vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#7aa2f7", bg = "#1a1b26" })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#7aa2f7", bg = "#1a1b26" })
        end,
    })
end

return M 
