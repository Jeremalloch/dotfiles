" Jeremy Malloch

" Plugins (with Vundle) {{{
" Start of Vundle settings
set nocompatible              " be iMproved, instead of backwards compatible (with vi)
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
Plugin 'vim-airline/vim-airline' " Status bar line at the bottom of the screen
Plugin 'scrooloose/nerdtree' " Nerdtree for file browsing
Plugin 'vim-syntastic/syntastic' " Linter for various languages
Plugin 'tpope/vim-surround' " Allows you to add or remove surrounding quotes
" Plugin 'Valloric/YouCompleteMe' " Autocompletion
Plugin 'ctrlpvim/ctrlp.vim' " Fuzzy file search
Plugin 'sjl/gundo.vim' " Vim undo tree visualization

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on
" End of Vundle code
" }}}

syntax enable " enabling syntax processing

" Tabs and spaces settings {{{
set tabstop=4 " Tabs are 4 spaces
set expandtab " When a tab is inserted, 4 spaces are inserted in lieu of the tab
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4 " Shifting with << or >> will only be 4 spaces
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}

" UI & Colourscheme {{{
set relativenumber	" Show the number of lines above and below cursor line
set background=dark
let g:solarized_termcolors=256
" set termguicolors
colorscheme solarized " Use solarized colourscheme
set showcmd " Show the command being entered in the bottom
set wildmenu " Visual autocomplete for vim commands
set lazyredraw " Vim won't redraw the screen as often
" }}}

" Folding Settings {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " Folding level is determined by indentation
" space open/closes folds
nnoremap <space> za
" }}}

" Movement settings {{{
" move vertically by visual line, so on long lines, don't miss
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]
" }}}

" Leader shortcuts {{{
let mapleader="," " leader is comma
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>s :mksession<CR>
" }}}

" Search settings {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight with ,
nnoremap <leader><space> :nohlsearch<CR> 
set wildignore+=*/.git/*,*/tmp/*,*.swp " Tell vim to ignore these files }}}

" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.py setlocal tabstop=4
    autocmd BufEnter *.md setlocal ft=markdown
augroup END
" }}}

" Pick what search tool to use {{{
" Searching with ripgrep, silver-searcher or ack depending what's installed
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
    nnoremap <leader>g :rg
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
    nnoremap <leader>g :Ag
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" CtrlP settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" }}}

" NERDTree {{{
" If no file specified, enter NERDTree on vim startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <leader>n :NERDTreeToggle<CR>
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
" }}}

" Vim airline statu bar settings {{{
set laststatus=2
set ttimeoutlen=50
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
" }}}

" Save Vim backups in a more convenient place {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" YouCompleteMeSettings {{{
" Make sure You complete me uses right python
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = 'python'
" }}}

" Functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
"}}}

" vim:foldmethod=marker:foldlevel=0

" Inspired by https://dougblack.io/words/a-good-vimrc.html#ui
