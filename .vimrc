" Start of Vundle settings
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" Plugins from Github (format is user/repo)
Plugin 'tpope/vim-fugitive' " Git plugin
Plugin 'altercation/vim-colors-solarized' " Colour scheme plugin
Plugin 'powerline/powerline' " Powerline on the bottom of vim editing window
Plugin 'scrooloose/nerdtree' " Nerdtree for file browsing
Plugin 'davidhalter/jedi-vim' " Autocomplete plugin
Plugin 'vim-syntastic/syntastic' " Linter for various languages
Plugin 'tpope/vim-surround' " Allows you to add or remove surrounding quotes
Plugin 'ctrlpvim/ctrlp.vim' " Fuzzy file search
" vim-scripts repos
Bundle 'L9'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" End of Vundle code

syntax enable " enabling syntax processing
set nocompatible " Setting that VIM doesn't have to be backward compatible with VI, resulting in increased functionality
" Tabs and spaces settings
set tabstop=4 " The number of spaces that go into a tab
set softtabstop=4   " number of spaces in tab when editing
set expandtab " When a tab is inserted, 4 spaces are inserted in lieu of the tab

" UI related configurations
set relativenumber	" Show the number of lines above and below cursor line
" colorscheme solarized
set showcmd " Show the command being entered in the bottom
set cursorline " Highlight the current line in a file
set wildmenu " Visual autocomplete for vim commands
set lazyredraw " Vim won't redraw the screen as often
set showmatch " highlight matching [{()}] (if cursor is over one, highlights the closing one

" Search settings 
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight with ,
nnoremap <leader><space> :nohlsearch<CR> 

" Folding Settings
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " Folding level is determined by indentation
" space open/closes folds
nnoremap <space> za

" Movement settings
" move vertically by visual line, so on long lines, don't miss
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV `[v`]

" Settings for syntastic, the linter
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
