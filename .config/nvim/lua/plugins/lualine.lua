-- Statusline (nvim-lualine/lualine.nvim)

local status, lualine = pcall(require, "lualine")
if not status then
    return
end

lualine.setup({
    options = {
        theme = "tokyonight",
        globalstatus = true, -- single statusline for the whole editor (sets laststatus=3)
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
