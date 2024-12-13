vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.tpl",
    command = "set filetype=html",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "scss",
    command = "setlocal iskeyword+=@-@",
})

vim.keymap.set("n", "te", ":tabedit<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", "sv", ":vsplit<CR><C-w><C-w>", { silent = true })
vim.keymap.set("n", "sn", ":sp<CR><C-w>j", { silent = true })

vim.keymap.set("n", "<C-f>", function()
    require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))
end, { silent = true })

vim.keymap.set("n", "sh", "<C-w>t", { silent = true })
vim.keymap.set("n", "sl", "<C-w>w", { silent = true })

vim.keymap.set("n", "<C-q>", ":bp|sp|bn|bd<CR>", { silent = true })

function InputParentheses(char) end
function InputCloseParenthesis(char) end
function InputQuot(char) end
function InputCR() end
function InputSpace() end
function InputBS() end
function ClipInParentheses(char) end
function ClipInQuot(char) end
function ReturnHTMLFormat() end

vim.keymap.set("i", "{", "v:lua.InputParentheses('{')", { expr = true })
vim.keymap.set("i", "[", "v:lua.InputParentheses('[')", { expr = true })
vim.keymap.set("i", "(", "v:lua.InputParentheses('(')", { expr = true })

vim.keymap.set("i", "}", "v:lua.InputCloseParenthesis('}')", { expr = true })
vim.keymap.set("i", "]", "v:lua.InputCloseParenthesis(']')", { expr = true })
vim.keymap.set("i", ")", "v:lua.InputCloseParenthesis(')')", { expr = true })

vim.keymap.set("i", "'", "v:lua.InputQuot(\"'\")", { expr = true })
vim.keymap.set("i", "\"", "v:lua.InputQuot('\"')", { expr = true })
vim.keymap.set("i", "`", "v:lua.InputQuot('`')", { expr = true })

vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = true })
vim.keymap.set("n", "<C-b>", ":wq!<CR>", { silent = true })
vim.keymap.set("i", "<C-b>", "<Esc>:wq!<CR>", { silent = true })

vim.keymap.set("i", "<TAB>", "coc#pum#visible() ? coc#pum#next(1) : '<TAB>'", { expr = true, silent = true })
vim.keymap.set("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { expr = true, silent = true })

vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("n", "<F6>", ":GoRun<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<leader>i", ":GoImplement<CR>", { buffer = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.keymap.set("n", "<C-]>", "<Plug>(coc-definition)", { buffer = true, silent = true })
        vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { buffer = true, silent = true })
        vim.keymap.set("n", "<F6>", ":RustRun<CR>", { buffer = true, silent = true })
    end,
})
