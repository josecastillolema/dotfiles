" Trailing spaces
syntax on               " Enabled by sensible.vim
highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /\s\+$/
