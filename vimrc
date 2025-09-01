" Jeremy Malloch
"
" Plugins (with vim-plug) {{{
set nocompatible              " be iMproved, instead of backwards compatible (with vi)

" Start of vim-plug settings
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'tpope/vim-fugitive'                 " Git plugin
Plug 'tpope/vim-surround'                  " Add/remove surrounding characters
Plug 'mbbill/undotree'                     " Vim undo tree visualizatio

" UI & Theme
Plug 'altercation/vim-colors-solarized'    " Colour scheme plugin
Plug 'vim-airline/vim-airline'             " Status bar
Plug 'vim-airline/vim-airline-themes'      " Themes for vim airline

" File Navigation & Editing
Plug 'preservim/nerdtree'                  " File tree explorer
Plug 'preservim/nerdcommenter'             " Comment & uncomment easily
Plug 'vim-scripts/indentpython.vim'        " Better python indentation

" For Code Intelligence 
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" For Fuzzy Finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize the plugin system
call plug#end()

filetype plugin indent on
syntax enable " enabling syntax processing
" End of vim-plug code
" }}}

" System Settings {{{
set clipboard=unnamedplus
" }}}

" Tabs and spaces settings {{{
set tabstop=4 " Tabs are 4 spaces
set expandtab " When a tab is inserted, 4 spaces are inserted in lieu of the tab
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4 " Shifting with << or >> will only be 4 spaces
setlocal textwidth=79
set modelines=1
filetype indent on
filetype plugin on
set autoindent
set backspace=indent,eol,start " Make sure backspace works properly
" }}}

" UI & Colourscheme {{{
set relativenumber	" Show the number of lines above and below cursor line
set number
set background=light
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

" Movement settings {{{
" move vertically by visual line, so on long lines, don't miss
" nnoremap <leader>jj <CR>L zt<CR>
" nnoremap <leader>k <CR>H zb<CR>
set scrolloff=3                 " Keep at least 3 lines above/below
set sidescrolloff=3             " Keep at least 3 lines left/right
" highlight last inserted text
nnoremap gV `[v`]
set mouse=a
" }}}

" Leader shortcuts {{{
let mapleader="," " leader is comma
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>ez :tabnew ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>rl :call ToggleNumber()<CR> " Switch between absolute and relative line number
" }}}

" UndoTree Settings {{{
nnoremap <leader>u :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif
" }}}

" Opening new Buffer Behaviour {{{
set splitbelow                  " Horizontal split below
set splitright                  " Vertical split right
set switchbuf+=usetab,newtab
" }}}

" Search settings {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase                  " Case-insensitive search
set smartcase                   " Unless search contains uppercase letter
" turn off search highlight with ,
nnoremap <leader><space> :nohlsearch<CR>
set wildignore+=*/.git/*,*/tmp/*,*.swp " Tell vim to ignore these files
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR> " K searches for word under key }}}

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
    " Filetype python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
    autocmd BufEnter *.md setlocal ft=markdown
augroup END
" }}}

" Pick what search tool to use {{{
" Searching with ripgrep, silver-searcher or ack depending what's installed
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
    nnoremap <leader>g :vimgrep
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    nnoremap <leader>g :!Ag
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" NERDTree {{{
" If no file specified, enter NERDTree on vim startup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <leader>n :NERDTreeToggle<CR>
" }}}

" NERDCommenter {{{

let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
" }}}

" Vim Airline {{{
set laststatus=2
set ttimeoutlen=50
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
" }}}

" Save Vim backups in a more convenient place {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" FZF (FUZZY FINDER) SETTINGS {{{
" <leader>ff to find files
nnoremap <leader>ff :Files<CR>
" <leader>fg to find files tracked by Git
nnoremap <leader>fg :GFiles<CR>
" <leader>gb to search buffers
nnoremap <leader>fb :Buffers<CR>
" <leader>rg to Ripgrep for content in files
nnoremap <leader>rg :Rg<CR>
" }}}

" COC.NVIM (LSP CLIENT) SETTINGS {{{
" Key mappings for LSP features
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <leader>d for diagnostics
nmap <leader>d <Plug>(coc-diagnostic-info)
" }}}

" Functions {{{
" toggle between number and relativenumber
func! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfu
com! TN call ToggleNumber()

" Word Processing Mode - English spell check
func! WordProcessorMode()
 setlocal textwidth=80
 setlocal spell spelllang=en_us
 setlocal noexpandtab
 setlocal colorcolumn=80
endfu
com! WP call WordProcessorMode()
"}}}

" Git (Fugitive) Settings {{{
nnoremap <leader>gb :Gblame<CR>
" }}}
"
" vim:foldmethod=marker:foldlevel=0
