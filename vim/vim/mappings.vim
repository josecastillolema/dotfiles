let mapleader = ','
let maplocalleader= ','

map <leader>f :Explore<cr>
map <leader>p :Explore<cr>
map <leader>c :bw<cr>
map <C-F> :Explore<cr>
map <C-P> :Explore<cr>
map <C-C> :bw<cr>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
