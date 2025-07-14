-- Plugin configuration initialization

-- Load all plugin configurations
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.ui")
require("plugins.theme")
require("plugins.copilot")
-- Load completion setup
local completion = require("plugins.completion")
completion.setup()

-- Prettier configuration
vim.g["prettier#autoformat"] = 0  -- Disable autoformat to use our custom autocmd
vim.g["prettier#autoformat_require_pragma"] = 0
vim.g["prettier#exec_cmd_async"] = 1 
