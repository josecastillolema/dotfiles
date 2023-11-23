set cursorline
set invlist
set number
set rnu
set scrolloff=9999
set termguicolors

" just use the terminal's background color
"if (has("autocmd") && !has("gui_running"))
  "augroup colorset
    "autocmd!
    "let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    "autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  "augroup END
"endif
colorscheme onedark

autocmd TermOpen * setlocal nonumber norelativenumber

autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'Visual'), timeout=-1}

highlight Comment cterm=italic gui=italic

" | as the insert cursor (needed for vim)
"let &t_SI = "\e[6 q"
"let &t_EI = "\e[2 q"
