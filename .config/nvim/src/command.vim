au BufNewFile,BufRead *.tpl set filetype=html
autocmd StdinReadPre * let s:std_in=1
autocmd FileType scss setl iskeyword+=@-@
nmap te :tabedit
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>
nmap sv :vsplit<Return><C-w><C-w>
nnoremap sn :<C-u>sp<CR><C-w>j
nnoremap <C-f> :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>
nmap sh <C-w>t
nmap sl <C-w>w
map <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>
inoremap <expr> { InputParentheses("{")
inoremap <expr> [ InputParentheses("[")
inoremap <expr> ( InputParentheses("(")
inoremap <expr> } InputCloseParenthesis("}")
inoremap <expr> ] InputCloseParenthesis("]")
inoremap <expr> ) InputCloseParenthesis(")")
inoremap <expr> ' InputQuot("\'")
inoremap <expr> " InputQuot("\"")
inoremap <expr> ` InputQuot("\`")
inoremap <expr> <CR> InputCR()
inoremap <expr> <Space> InputSpace()
inoremap <expr> <BS> InputBS()
xnoremap <expr> { ClipInParentheses("{")
xnoremap <expr> [ ClipInParentheses("[")
xnoremap <expr> ( ClipInParentheses("(")
xnoremap <expr> ' ClipInQuot("\'")
xnoremap <expr> " ClipInQuot("\"")
xnoremap <expr> ` ClipInQuot("\`")
inoremap <expr> <CR> ReturnHTMLFormat()
nnoremap <silent> <C-j> <Esc>$a<CR>
inoremap <silent> <C-j> <Esc>$a<CR>
nnoremap <silent> <C-h> $
inoremap <silent> <C-h> <Esc>$a
inoremap <silent> <S-CR> <Esc>$a<CR>
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <C-c>:w<CR>
nnoremap <silent> <C-b> :wq!<CR>
inoremap <silent> <C-b> <Esc>:wq!<CR>
nnoremap   <silent>   ww   :FloatermToggle<CR>
tnoremap   <silent>   ww   <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <CR> i
inoremap <silent> <C-l> <ESC>
nnoremap <silent> <C-l> <ESC>
filetype plugin indent on
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
hi Floaterm guibg=black
hi FloatermBorder guibg=orange guifg=cyan
nnoremap <silent> <leader>q :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1)
                              \: "\<C-g>u\<TAB>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>" " "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

augroup GoMappings
    autocmd!
    autocmd FileType go nnoremap <buffer> <CR> <Nop>
    autocmd FileType go nnoremap <buffer> <silent> <F6> :GoRun<CR>
    autocmd FileType go nnoremap <buffer> <leader>i :GoImplement<CR>
    autocmd FileType go nnoremap <buffer> <leader>r :GoReferrers<CR>
augroup END
augroup TypescriptMappings
    autocmd!
    autocmd FileType typescript nmap <silent> <C-]> <Plug>(coc-definition)
    autocmd FileType typescript nmap <silent> gd <Plug>(coc-implementation)
    autocmd FileType typescript nnoremap <buffer> <C-t> <C-o>
augroup END
augroup RustMappings
    autocmd!
    autocmd FileType rust nmap <silent> <C-]> <Plug>(coc-definition)
    autocmd FileType rust nmap <silent> gd <Plug>(coc-implementation)
    autocmd FileType rust nnoremap <buffer> <silent> <F6> :RustRun<CR>
    autocmd FileType rust nnoremap <buffer> <C-t> <C-o>
augroup END
