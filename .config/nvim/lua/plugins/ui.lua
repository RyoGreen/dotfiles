-- UI and dashboard configuration

-- ASCII art and dashboard settings
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
                { icon = '  ', desc = 'Find File                 ', action = 'FzfLua files', shortcut = 'SPC f f' },
                { icon = '  ', desc = 'Find Word                 ', action = 'FzfLua live_grep', shortcut = 'SPC f w' },
                { icon = '  ', desc = 'Recent Files              ', action = 'FzfLua oldfiles', shortcut = 'SPC f r' },
                { icon = '  ', desc = 'Open GitHub Repo          ', action = 'lua require("custom").open_github()', shortcut = 'SPC g o' },
                { icon = '⚙️ ', desc = 'Open Settings             ', action = ':e ~/.config/nvim/init.lua', shortcut = 'SPC s e' },
            },
        }
    }
end

-- Bufferline settings
local status, bufferline = pcall(require, "bufferline")
if status then
    bufferline.setup {
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
        -- Disable netrw at the very start of your init.lua
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = false,
        hijack_unnamed_buffer_when_opening = false,

        -- General settings
        sort = { sorter = "name" },
        root_dirs = {},
        prefer_startup_root = false,
        sync_root_with_cwd = true,
        reload_on_bufenter = false,
        respect_buf_cwd = false,

        -- View settings
        view = {
            centralize_selection = false,
            width = { min = 30, max = 50 },
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
        },

        -- Renderer settings
        renderer = {
            add_trailing = false,
            group_empty = true,
            highlight_git = "none",
            full_name = false,
            highlight_opened_files = "name",
            hidden_display = "simple",
            root_folder_label = ":~:s?$?/..?",
            indent_width = 2,
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
            icons = {
                web_devicons = {
                    file = { color = true },
                },
                git_placement = "before",
                modified_placement = "after",
                padding = { icon = " " },
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                    modified = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "",
                    modified = "●",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
        },

        -- Update focused file
        update_focused_file = {
            enable = true,
            update_root = false,
            ignore_list = {},
        },

        -- Modified
        modified = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },

        -- Diagnostics
        diagnostics = {
            enable = true,
            show_on_dirs = false,
            show_on_open_dirs = true,
            debounce_delay = 50,
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR,
            },
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },

        -- Filters
        filters = {
            dotfiles = false,
            git_ignored = true,
            git_clean = false,
            no_buffer = false,
            custom = { "^.git$" },
            exclude = {},
        },

        -- Filesystem watchers
        filesystem_watchers = {
            enable = true,
            debounce_delay = 50,
            ignore_dirs = {},
        },

        -- Git integration
        git = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
            timeout = 400,
        },

        -- Actions
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false,
            },
            expand_all = {
                max_folder_discovery = 300,
                exclude = {},
            },
            file_popup = {
                open_win_config = {
                    col = 1,
                    row = 1,
                    relative = "cursor",
                    border = "shadow",
                    style = "minimal",
                },
            },
            open_file = {
                quit_on_open = true,
                resize_window = true,
                window_picker = {
                    enable = false,
                },
            },
            remove_file = {
                close_window = true,
            },
        },

        -- Trash settings
        trash = {
            cmd = "trash",
        },

        -- Confirmation prompts
        ui = {
            confirm = {
                remove = true,
                trash = true,
            },
        },

        -- Live filter
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true,
        },

        -- Tab settings
        tab = {
            sync = {
                open = false,
                close = false,
                ignore = {},
            },
        },

        -- Notify settings
        notify = {
            threshold = vim.log.levels.INFO,
        },

        -- Log settings (disable for performance)
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                dev = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false,
            },
        },

        on_attach = function(bufnr)
            require("nvim-tree.api").map.on_attach.default(bufnr)
            vim.keymap.set("n", "s", "<Nop>", { buffer = bufnr, noremap = true, silent = true, nowait = true })
        end,
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
