set confirm
set cursorline
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
