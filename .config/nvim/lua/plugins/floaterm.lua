-- Floaterm configuration (voldikss/vim-floaterm)
-- Recommended defaults + tokyonight (moon) harmonized appearance

-- Window geometry / behavior
vim.g.floaterm_width = 0.9            -- 90% of editor width
vim.g.floaterm_height = 0.9           -- 90% of editor height
vim.g.floaterm_position = "center"    -- center the floating window
vim.g.floaterm_title = "floaterm: $1/$2" -- show current/total in the title
vim.g.floaterm_borderchars = "─│─│╭╮╯╰" -- rounded corners
vim.g.floaterm_autoinsert = 1         -- enter terminal-insert mode automatically
vim.g.floaterm_autoclose = 1          -- close the window when the job exits successfully
vim.g.floaterm_opener = "edit"        -- open files (e.g. from lf/ranger) in the current window

-- Appearance: match tokyonight moon (dark floats + telescope blue border)
local function set_floaterm_hl()
    local border = "#7aa2f7" -- same blue used for Telescope borders
    local bg = "#1e2030"     -- tokyonight moon bg_dark (float background)
    vim.api.nvim_set_hl(0, "Floaterm", { bg = bg })
    vim.api.nvim_set_hl(0, "FloatermBorder", { fg = border, bg = bg })
end

set_floaterm_hl()

-- Re-apply after any colorscheme reload so the colors persist
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_floaterm_hl,
})

-- Keep the floating terminal aligned when the editor is resized.
-- floaterm computes its geometry when the window is opened, so if it is
-- open while the OS/tmux pane is resized (e.g. split to half) it keeps the
-- old size and drifts off-center. Recompute it on VimResized.
vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "floaterm" then
            vim.cmd("FloatermUpdate --width=0.9 --height=0.9 --position=center")
        end
    end,
})
