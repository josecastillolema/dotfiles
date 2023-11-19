let mapleader = ' '
let maplocalleader = ' '

" startsel Using a shifted special key starts selection
" stopsel  Using a not-shifted special key stops selection
set keymodel=startsel,stopsel

map <leader>f :Explore<cr>
map <leader>p :Explore<cr>
map <leader>c :bw<cr>
map <C-F> :Explore<cr>
map <C-P> :Explore<cr>
map <C-C> :bw<cr>

"noremap $ $l   " goes to the extra space at the end of the line. Not working

nnoremap <C-a> ggVG
nnoremap <C-v> "*p
vnoremap <C-c> "*y

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
