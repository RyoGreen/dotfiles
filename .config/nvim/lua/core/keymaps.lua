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
    require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))
end, opts)

-- Floaterm
map("n", "ww", ":FloatermToggle<CR>", opts)
map("t", "ww", "<C-\\><C-n>:FloatermToggle<CR>", opts)
map("n", "<CR>", "i", opts)
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

-- COC
map("i", "<TAB>", "coc#pum#visible() ? coc#pum#next(1) : '<TAB>'", { expr = true, silent = true })
map("i", "<S-TAB>", "coc#pum#visible() ? coc#pum#prev(1) : '<S-TAB>'", { expr = true, silent = true })
map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { expr = true, silent = true })

-- Copilot
map("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true }) 