-- Global variables configuration

-- Go language settings
vim.g.go_highlight_array_whitespace_error = 1
vim.g.go_highlight_chan_whitespace_error = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_space_tab_error = 1
vim.g.go_highlight_trailing_whitespace_error = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_arguments = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_variable_assignments = 1
vim.g.go_highlight_variable_declarations = 1

-- Search tools
vim.g.ackprg = 'ag --nogroup --nocolor --column'

-- Prettier
vim.g['prettier#autoformat'] = 1

-- Closetag
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.tpl'

-- Rust
vim.g.rustfmt_autosave = 1
vim.g.rust_analyzer_completion_enable_autoimport = false

-- NERDTree (if still using)
vim.g.NERDTreeShowHidden = 1

-- Copilot
vim.g.copilot_no_tab_map = true
