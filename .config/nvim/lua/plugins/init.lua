-- Plugin configuration initialization

-- Load all plugin configurations
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.ui")
require("plugins.theme")
-- Load completion setup
local completion = require("plugins.completion")
completion.setup() 
