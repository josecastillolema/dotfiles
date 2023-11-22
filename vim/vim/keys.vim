let mapleader = ' '
let maplocalleader = ' '

" startsel Using a shifted special key starts selection
" stopsel  Using a not-shifted special key stops selection
set keymodel=startsel,stopsel

" Netrw
"map <C-P> :Explore<cr>
"map <C-C> :bw<cr>

"noremap $ $l   " goes to the extra space at the end of the line. Not working

"inoremap <LeftRelease> "+y<LeftRelease>
"nnoremap <LeftRelease> "+y<LeftRelease>
"vnoremap <LeftRelease> "+y<LeftRelease>

" Save
nnoremap <silent> <C-s> :update<cr>
vnoremap <silent> <C-s> <C-c>:update<cr>
inoremap <silent> <C-s> <C-o>:update<cr>

" Exit
nnoremap <silent> <C-x> :q<CR>
vnoremap <silent> <C-x> <C-c>:q<cr>
inoremap <silent> <C-x> <C-o>:q<cr>

" Select copy paste
inoremap <C-a> <ESC>ggVG
nnoremap <C-a> ggVG
vnoremap <C-c> "*y
"inoremap <C-v> <ESC>"*p
"nnoremap <C-v> "*P

" Switch split
nmap <leader>sv <C-w>t<C-w>H
nmap <leader>sh <C-w>t<C-w>K

" Move selection
nnoremap <A-down> :m+<cr>==
nnoremap <A-up> :m-2<cr>==
inoremap <A-down> <Esc>:m+<cr>==gi
inoremap <A-up> <Esc>:m-2<cr>==gi
vnoremap <A-down> :m'>+<cr>gv=gv
vnoremap <A-up> :m-2<cr>gv=gv
vmap <A-left> <gv
vmap <A-right> >gv
nnoremap <A-left> :<<cr>
nnoremap <A-right> :><cr>

" Move between buffers
nnoremap <A-tab> :bnext<cr>
nnoremap <S-A-tab> :bprev<cr>

" Telescope
map <C-p> :Telescope file_browser<cr>
map <C-g> :Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>

" NvimTree
map <C-t> <cmd>NvimTreeToggle<cr>
nnoremap <leader>t <cmd>NvimTreeToggle<cr>

" Commenter
map <C-/> <plug>NERDCommenterToggle<cr>

" Terminal
" Exit insert mode with Esc
:tnoremap <Esc> <C-\><C-n>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
