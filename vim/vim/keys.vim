let mapleader = ' '
let maplocalleader = ' '

" startsel Using a shifted special key starts selection
" stopsel  Using a not-shifted special key stops selection
set keymodel=startsel,stopsel

"map <C-P> :Explore<cr>
map <C-P> :Telescope file_browser<cr>
"map <C-C> :bw<cr>

"noremap $ $l   " goes to the extra space at the end of the line. Not working

" Select copy paste
inoremap <C-a> <ESC>ggVG
nnoremap <C-a> ggVG
vnoremap <C-c> "*y
inoremap <C-v> <ESC>"*p
nnoremap <C-v> "*P

" Switch split
nmap <leader>sv <C-w>t<C-w>H
nmap <leader>sh <C-w>t<C-w>K

" Move selection
"vnoremap <C-S-Up>   :m '<-2<CR>gv=gv
"vnoremap <C-S-Down> :m '>+1<CR>gv=gv
"xnoremap <C-S-Up> xkP`[V`]
"xnoremap <C-S-Down> xp`[V`]
"xnoremap <C-S-Left> <gv
"xnoremap <C-S-Right> >gv
nnoremap <A-down> :m+<CR>==
nnoremap <A-up> :m-2<CR>==
inoremap <A-down> <Esc>:m+<CR>==gi
inoremap <A-up> <Esc>:m-2<CR>==gi
vnoremap <A-down> :m'>+<CR>gv=gv
vnoremap <A-up> :m-2<CR>gv=gv
vmap <A-Left> <gv
vmap <A-Right> >gv
nnoremap <A-left> :<<cr>
nnoremap <A-right> :><cr>


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
