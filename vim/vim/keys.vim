let mapleader = ' '
let maplocalleader = ' '

" startsel Using a shifted special key starts selection
" stopsel  Using a not-shifted special key stops selection
set keymodel=startsel,stopsel

"map <C-P> :Explore<cr>
map <C-P> :Telescope file_browser<cr>
"map <C-C> :bw<cr>

"noremap $ $l   " goes to the extra space at the end of the line. Not working

nnoremap <C-a> ggVG
nnoremap <C-v> "*p
vnoremap <C-c> "*y

" Telescope
nnoremap <leader>ff <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Terminal
" Exit insert mode with Esc
:tnoremap <Esc> <C-\><C-n>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
