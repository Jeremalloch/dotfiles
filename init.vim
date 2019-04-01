" Plugins (with Plug) {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'altercation/vim-colors-solarized' " Colour scheme plugin
Plug 'vim-airline/vim-airline' " Status bar line at the bottom of the screen
Plug 'vim-airline/vim-airline-themes' " Themes for vim airline
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file search
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" End of of Plug code
" Initialize plugin system
call plug#end()
" }}}

" UI & Colourscheme {{{
set relativenumber	" Show the number of lines above and below cursor line
set number
set background=dark
let g:solarized_termcolors=256
colorscheme solarized " Use solarized colourscheme
set showcmd " Show the command being entered in the bottom
set wildmenu " Visual autocomplete for vim commands
set lazyredraw " Vim won't redraw the screen as often
" }}}

" Folding Settings {{{
set foldenable          " enable folding
set foldlevelstart=99   " open most folds by default
set foldmethod=indent   " Folding level is determined by indentation
" space open/closes folds
nnoremap <space> za
" }}}

" Git (Fugitive) Settings {{{
nnoremap <leader>gb :Gblame<CR>
" }}}

" Leader shortcuts {{{
let mapleader="," " leader is comma
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>ez :tabnew ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>rl :call ToggleNumber()<CR> " Switch between absolute and relative line number
" }}}
"
nnoremap <leader>n :NERDTreeToggle<CR>

" Deoplete config {{{
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
" }}}
