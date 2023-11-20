set cursorline
set number
set rnu
set termguicolors

autocmd TermOpen * setlocal nonumber norelativenumber

autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=-1}

" | as the insert cursor (needed for vim)
"let &t_SI = "\e[6 q"
"let &t_EI = "\e[2 q"
