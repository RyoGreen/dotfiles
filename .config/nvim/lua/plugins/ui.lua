-- UI plugins configuration

-- Dashboard settings
local status, dashboard = pcall(require, "dashboard")
if status then
    dashboard.setup {
        theme = 'hyper',
        config = {
            header = {
                ' ██████╗██╗  ██╗██╗ ██████╗  █████╗  ██████╗       ██████╗ ██╗   ██╗██╗     ██╗███████╗',
                '██╔════╝██║  ██║██║██╔════╝ ██╔══██╗██╔═══██╗      ██╔══██╗██║   ██║██║     ██║██╔════╝',
                '██║     ███████║██║██║  ███╗███████║██║   ██║█████╗██████╔╝██║   ██║██║     ██║█████╗  ',
                '██║     ██╔══██║██║██║   ██║██╔══██║██║   ██║╚════╝██╔═══╝ ██║   ██║██║     ██║██╔══╝  ',
                '╚██████╗██║  ██║██║╚██████╔╝██║  ██║╚██████╔╝      ██║     ╚██████╔╝███████╗██║██║     ',
                ' ╚═════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝       ╚═╝      ╚═════╝ ╚══════╝╚═╝╚═╝     ',
                '',
            },
            center = {
                { icon = '  ', desc = 'Find File                 ', action = 'Telescope find_files', shortcut = 'SPC f f' },
                { icon = '  ', desc = 'Find Word                 ', action = 'Telescope live_grep', shortcut = 'SPC f w' },
                { icon = '  ', desc = 'Recent Files              ', action = 'Telescope oldfiles', shortcut = 'SPC f r' },
                { icon = '  ', desc = 'Open GitHub Repo          ', action = 'lua require("custom").open_github()', shortcut = 'SPC g o' },
                { icon = '⚙️ ', desc = 'Open Settings             ', action = ':e ~/.config/nvim/init.lua', shortcut = 'SPC s e' },
            },
        }
    }
end

-- Bufferline settings
local status, bufferline = pcall(require, "bufferline")
if status then
    bufferline.setup{
        options = {
            mode = "buffers",
            separator_style = "slant",
            always_show_bufferline = true,
            offsets = {
                { filetype = "NvimTree", text = "File Explorer", text_align = "center", padding = 1 }
            },
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
            color_icons = true,
            show_tab_indicators = true,
        },
        highlights = {
            fill = { bg = "#1e1e2e" },
            background = { fg = "#666666", bg = "#1e1e2e" },
            buffer_selected = { fg = "#f8f8f2", bold = true, italic = false },
            separator = { fg = "#44475a", bg = "#1e1e2e" },
            separator_selected = { fg = "#f8f8f2", bg = "#1e1e2e" },
            modified = { fg = "#bd93f9" },
            modified_selected = { fg = "#ff79c6" },
        }
    }
end

-- NvimTree settings
local status, nvim_tree = pcall(require, "nvim-tree")
if status then
    nvim_tree.setup({
        -- 基本設定
        sort_by = "case_sensitive",
        view = {
            width = 30,
            side = "left",
            preserve_window_proportions = true,
        },
        renderer = {
            group_empty = true,
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = " ",
                    symlink = " ",
                    bookmark = " ",
                    modified = " ",
                    folder = {
                        arrow_closed = " ",
                        arrow_open = " ",
                        default = " ",
                        open = " ",
                        empty = " ",
                        empty_open = " ",
                        symlink = " ",
                        symlink_open = " ",
                    },
                    git = {
                        unstaged = " ",
                        staged = " ",
                        unmerged = " ",
                        renamed = " ",
                        untracked = " ",
                        deleted = " ",
                        ignored = " ",
                    },
                },
            },
        },
        filters = {
            dotfiles = false,
            git_ignored = false,
        },
        git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            timeout = 400,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            update_root = true,
        },
        actions = {
            open_file = {
                quit_on_open = false,
                resize_window = false,  -- リサイズも無効化
                window_picker = {
                    enable = false,  -- ウィンドウピッカーを無効化
                },
            },
            remove_file = {
                close_window = true,
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = " ",
                info = " ",
                warning = " ",
                error = " ",
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true,
        },
        log = {
            enable = false,
            truncate = true,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false,
            },
        },
    })
end

-- Key mappings for bufferline
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

-- Key mapping to close all buffers and show Dashboard
vim.keymap.set('n', 'sd', function()
    vim.cmd('bufdo bd')
    vim.cmd('Dashboard')
end, { silent = true })

-- Floaterm highlighting
vim.cmd('hi Floaterm guibg=black')
vim.cmd('hi FloatermBorder guibg=orange guifg=cyan') 
