set confirm
set invlist
set number
set rnu
"set scrolloff=9999
set termguicolors

" just use the terminal's background color
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
colorscheme onedark

" Highlights have to be set after loading the colorscheme
set cursorline
highlight CursorLine guibg=#2E3C43 

autocmd TermOpen * setlocal nonumber norelativenumber

autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'Visual'), timeout=-1}

autocmd FileType qf set nobuflisted

highlight Comment cterm=italic gui=italic
highlight FloatBorder  ctermfg=NONE ctermbg=NONE cterm=NONE
" | as the insert cursor (needed for vim)
"let &t_SI = "\e[6 q"
"let &t_EI = "\e[2 q"

" Close vim if the only window left is quickfix
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

"highlight iCursor guifg=white guibg=steelblue
"set guicursor+=i:ver100-iCursor

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Colorcolumn

set colorcolumn=80

" But set it to 100 chars when editing Kotlin.
"autocmd filetype kotlin setlocal colorcolumn=100

" Set colorcolumn's color to slightly lighter than my background
" so that it is visible but not an eyesore.
highlight ColorColumn guibg=#2E3C43

highlight ScrollView  guibg=#808080

" Only show the colorcolumn in the current window.
"autocmd WinLeave * set colorcolumn=0
"autocmd WinEnter * set colorcolumn=+0

" Does not work (at least with OCaml)
"augroup lsp_highlight_cursor_word
"  autocmd! * <buffer>
"  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
"  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
"augroup END

hi LspCodeLens guifg=grey
