let mapleader = ' '
let maplocalleader = ' '

" Avoid left move when leaving insert mode
inoremap <silent> <Esc> <Esc>`^

source $VIMRUNTIME/mswin.vim
unmap <C-z>

inoremap <c-w> <nop>
inoremap <c-w><Left> <esc><c-w><Left>
inoremap <c-w><Right> <esc><c-w><Right>
inoremap <c-w><Up> <esc><c-w><Up>
inoremap <c-w><Down> <esc><c-w><Down>

tnoremap <c-w><Left> <esc><c-w><Left>
tnoremap <c-w><Right> <esc><c-w><Right>
tnoremap <c-w><Up> <esc><c-w><Up>
tnoremap <c-w><Down> <esc><c-w><Down>

" startsel Using a shifted special key starts selection
" stopsel  Using a not-shifted special key stops selection
"set keymodel=startsel,stopsel

"nnoremap $ $l   " goes to the extra space at the end of the line. Not working

"inoremap <LeftRelease> "+y<LeftRelease>
"nnoremap <LeftRelease> "+y<LeftRelease>
"vnoremap <LeftRelease> "+y<LeftRelease>

" Save
"nnoremap <silent> <C-s> :update <cr>
"vnoremap <silent> <C-s> <C-c>:update <cr>
"inoremap <silent> <C-s> <esc>:update <cr>l
inoremap <silent> <C-s> <esc>:w <cr>

" Exit
nnoremap <silent> <M-x> :q<CR>
vnoremap <silent> <M-x> <C-c>:q<cr>
inoremap <silent> <M-x> <C-o>:q<cr>

" Select copy paste
"inoremap <C-a> <ESC>ggVG
"nnoremap <C-a> ggVG
"vnoremap <C-c> "*y
" Use <C-q> for entering Visual Block Mode
"inoremap <C-v> <ESC>"*p
"nnoremap <C-v> "*P
"vnoremap <Left> "*y
"vnoremap <Right> "*y`]l
"vnoremap <Up> "*yk
"vnoremap <Down> "*y
"vnoremap <ESC> "*y`]l
"vnoremap <LeftRelease> "*y
"vmap <2-LeftRelease> "*ygv

" Switch split
"nmap <leader>sv <C-w>t<C-w>H
"nmap <leader>sh <C-w>t<C-w>K

" Move selection
nnoremap <A-down> :m+<cr>==
nnoremap <A-up> :m-2<cr>==
inoremap <A-down> <Esc>:m+<cr>==gi
inoremap <A-up> <Esc>:m-2<cr>==gi
vnoremap <A-down> :m'>+<cr>gv=gv
vnoremap <A-up> :m-2<cr>gv=gv
vmap <Tab> >gv
vmap <S-Tab> <gv
nnoremap <Tab> :><cr>
nnoremap <S-Tab> :<<cr>
vmap <A-left> <gv
vmap <A-right> >gv
nnoremap <A-left> :<<cr>
nnoremap <A-right> :><cr>

" Move between buffers
nnoremap <A-tab> :bnext<cr>
nnoremap <S-A-tab> :bprev<cr>

" Netrw
"map <C-P> :Explore<cr>
"map <C-C> :bw<cr>

" Telescope
map <C-p> :Telescope file_browser<cr>
map <C-f> :Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>

" Quickfix
map <C-up>   :cprev <cr>
map <C-down> :cnext <cr>
inoremap <C-up>   <esc>:cprev <cr>
inoremap <C-down> <esc>:cnext  <cr>

" NvimTree
map <C-t> <cmd>NvimTreeToggle<cr>
nnoremap <leader>t <cmd>NvimTreeToggle<cr>

" Commenter
"map <C-/> <plug>NERDCommenterToggle gv<cr>
map <C-/> <plug>NERDCommenterToggle k<cr>
imap <C-/> <esc>:call nerdcommenter#Comment("n", "Toggle")<CR>

" Terminal
" Exit insert mode with Esc
:tnoremap <Esc> <C-\><C-n>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"augroup FugitiveMappings
"  autocmd!
"  autocmd FileType git nmap <buffer> <C-down> <SNR>59_NextItem(v:count1)<CR>
"augroup

lua << EOF

-- Map arrow keys for wildmenu completion
-- It makes the command pallent more usable
vim.api.nvim_set_keymap('c', '<Down>', 'v:lua.get_wildmenu_key("<right>", "<down>")', { expr = true })
vim.api.nvim_set_keymap('c', '<Up>', 'v:lua.get_wildmenu_key("<left>", "<up>")', { expr = true })
function _G.get_wildmenu_key(key_wildmenu, key_regular)
return vim.fn.wildmenumode() ~= 0 and key_wildmenu or key_regular
end
