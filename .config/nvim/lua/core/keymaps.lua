-- Basic key mappings

local map = vim.keymap.set
local opts = { silent = true }

-- Basic navigation
map("n", "te", ":tabedit<CR>", opts)
map("n", "<S-Tab>", ":tabprev<CR>", opts)
map("n", "<Tab>", ":tabnext<CR>", opts)
map("n", "sv", ":vsplit<CR><C-w><C-w>", opts)
map("n", "sn", ":sp<CR><C-w>j", opts)

-- Window navigation
map("n", "sh", "<C-w>t", opts)
map("n", "sl", "<C-w>w", opts)

-- Buffer management
map("n", "<C-q>", ":bp|sp|bn|bd<CR>", opts)

-- File operations
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<C-c>:w<CR>", opts)
map("n", "<C-b>", ":wq!<CR>", opts)
map("i", "<C-b>", "<Esc>:wq!<CR>", opts)

-- Additional mappings
map("n", "<C-j>", "<Esc>$a<CR>", opts)
map("i", "<C-j>", "<Esc>$a<CR>", opts)
map("n", "<C-h>", "$", opts)
map("i", "<C-h>", "<Esc>$a", opts)
map("i", "<S-CR>", "<Esc>$a<CR>", opts)

-- Telescope
map("n", "<C-f>", function()
    require("telescope.builtin").find_files()
end, opts)

-- LSP and COC key mappings for definition jumping
map("n", "gd", "<Plug>(coc-definition)", opts)
map("n", "gD", "<Plug>(coc-declaration)", opts)
map("n", "gi", "<Plug>(coc-implementation)", opts)
map("n", "gr", "<Plug>(coc-references)", opts)
map("n", "K", "<Plug>(coc-hover)", opts)
map("n", "<C-k>", "<Plug>(coc-signature-help)", opts)

-- COC specific mappings
map("n", "<space>rn", "<Plug>(coc-rename)", opts)
map("n", "<space>ca", "<Plug>(coc-codeaction)", opts)
map("n", "<space>f", "<Plug>(coc-format)", opts)
map("n", "<space>qf", "<Plug>(coc-fix-current)", opts)

-- Diagnostic navigation
map("n", "[d", "<Plug>(coc-diagnostic-prev)", opts)
map("n", "]d", "<Plug>(coc-diagnostic-next)", opts)

-- Floaterm
map("n", "ww", ":FloatermToggle<CR>", opts)
map("t", "ww", "<C-\\><C-n>:FloatermToggle<CR>", opts)
-- Removed problematic Enter key mapping
map("i", "<C-l>", "<ESC>", opts)
map("n", "<C-l>", "<ESC>", opts)

map("n", "<F7>", ":FloatermNew<CR>", opts)
map("t", "<F7>", "<C-\\><C-n>:FloatermNew<CR>", opts)
map("n", "<F8>", ":FloatermPrev<CR>", opts)
map("t", "<F8>", "<C-\\><C-n>:FloatermPrev<CR>", opts)
map("n", "<F9>", ":FloatermNext<CR>", opts)
map("t", "<F9>", "<C-\\><C-n>:FloatermNext<CR>", opts)

-- NvimTree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>f", ":NvimTreeFindFile<CR>", opts)
map("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
map("n", "<leader>n", ":NvimTreeFocus<CR>", opts)

-- Language-specific mappings
-- Go mappings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("n", "<CR>", "<Nop>", { buffer = true })
        vim.keymap.set("n", "<F6>", ":GoRun<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<leader>i", ":GoImplement<CR>", { buffer = true })
        vim.keymap.set("n", "<leader>r", ":GoReferrers<CR>", { buffer = true })
    end
})

-- TypeScript mappings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript",
    callback = function()
        vim.keymap.set("n", "<C-]>", "<Plug>(coc-definition)", { buffer = true, silent = true })
        vim.keymap.set("n", "gd", "<Plug>(coc-implementation)", { buffer = true, silent = true })
        vim.keymap.set("n", "cr", "<Plug>(coc-references)", { buffer = true, silent = true })
        vim.keymap.set("n", "<C-t>", "<C-o>", { buffer = true })
    end
})

-- Rust mappings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.keymap.set("n", "gd", "<Plug>(coc-implementation)", { buffer = true, silent = true })
        vim.keymap.set("n", "cr", "<Plug>(coc-references)", { buffer = true, silent = true })
        vim.keymap.set("n", "<F6>", ":RustRun<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<C-t>", "<C-o>", { buffer = true })
    end
}) 
