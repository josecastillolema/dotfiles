" | as the insert cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" set mouse=a
set nowrap
set smartindent

set ts=3                 " Tabulación de 3 caracteres
set sw=3                 " Identado de 3 caracteres
set expandtab            " Cambia los tabs por espacios

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
