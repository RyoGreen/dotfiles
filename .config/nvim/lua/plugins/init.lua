-- Plugin configuration initialization

-- Load all plugin configurations
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.ui")
require("plugins.theme")
-- Delay completion setup to ensure COC is loaded
vim.defer_fn(function()
    local completion = require("plugins.completion")
    completion.setup()
end, 500) 
