-- Diagnostics / quickfix list (folke/trouble.nvim)

local status, trouble = pcall(require, "trouble")
if not status then
    return
end

trouble.setup({})

local map = vim.keymap.set
local opts = { silent = true }
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", opts)
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts)
map("n", "<leader>xs", "<cmd>Trouble symbols toggle<CR>", opts)
map("n", "<leader>xl", "<cmd>Trouble lsp toggle<CR>", opts)
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", opts)
