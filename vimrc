" Jeremy Malloch
"
" TODO: switch to vim.plug so different plugins can be used for different
" programs (eg Haskell vs C vs Python)

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
Plugin 'vim-airline/vim-airline-themes' " Themes for vim airline
Plugin 'scrooloose/nerdtree' " Nerdtree for file browsing
Plugin 'scrooloose/nerdcommenter' " Comment & uncomment code easily
Plugin 'vim-syntastic/syntastic' " Linter for various languages
Plugin 'tpope/vim-surround' " Allows you to add or remove surrounding quotes
Plugin 'Valloric/YouCompleteMe' " Autocompletion
Plugin 'ctrlpvim/ctrlp.vim' " Fuzzy file search
Plugin 'sjl/gundo.vim' " Vim undo tree visualization

" Latex Plugins
Plugin 'lervag/vimtex'
" Plugin 'brennier/quicktex'  " Quick complete

" Haskell
Plugin 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plugin 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plugin 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plugin 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
Plugin 'Shougo/vimproc.vim'
let $PATH = $PATH . ':' . expand('~/Library/Haskell/bin') " Allow ghc-mod to be discovered

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on
syntax enable " enabling syntax processing
" End of Vundle code
" }}}

" Tabs and spaces settings {{{
set tabstop=4 " Tabs are 4 spaces
set expandtab " When a tab is inserted, 4 spaces are inserted in lieu of the tab
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4 " Shifting with << or >> will only be 4 spaces
set modelines=1
filetype indent on
filetype plugin on
set autoindent
set backspace=indent,eol,start " Make sure backspace works properly
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
set foldlevelstart=10   " open most folds by default
set foldmethod=indent   " Folding level is determined by indentation
" space open/closes folds
nnoremap <space> za
" }}}

" Movement settings {{{
" move vertically by visual line, so on long lines, don't miss
" nnoremap j gj
" nnoremap k gk
nnoremap gj 25j
nnoremap gk 25k
set scrolloff=3                 " Keep at least 3 lines above/below
set sidescrolloff=3             " Keep at least 3 lines left/right
" highlight last inserted text
nnoremap gV `[v`]
set mouse=a
" }}}

" Leader shortcuts {{{
let mapleader="," " leader is comma
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>ez :tabnew ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>l :call ToggleNumber() " Switch between absolute and relative line number
" }}}

" Split Opening Behaviour {{{
set splitbelow                  " Horizontal split below
set splitright                  " Vertical split right
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
    autocmd BufEnter *.py setlocal tabstop=4
    " Filetype python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
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

" Syntastic {{{
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" let g:syntastic_error_symbol = '❌'
" let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_style_warning_symbol = '💩'

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn

let g:syntastic_python_checkers=['pylint']
" }}}

" vimtex (LaTeX) {{{
let g:vimtex_view_method = 'skim' " Set PDF viewer
" Use YouCompleteMe for autocompletion
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
" }}}

" ghc-mod {{{
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
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

" YouCompleteMeSettings {{{
" Make sure YouCompleteMe uses the right python version
nnoremap <leader>jd :YcmCompleter GoTo<CR> " leader jd goes to definition if possible
let g:ycm_path_to_python_interpreter = '/Users/jeremymalloch/.pyenv/shims/python2'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 1
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_show_diagnostics_ui=1
let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_filetype_blacklist={
            " \ 'vim' : 1,
            " \ 'tagbar' : 1,
            " \ 'qf' : 1,
            " \ 'notes' : 1,
            " \ 'markdown' : 1,
            " \ 'md' : 1,
            " \ 'unite' : 1,
            " \ 'text' : 1,
            " \ 'vimwiki' : 1,
            " \ 'pandoc' : 1,
            " \ 'infolog' : 1,
            " \ 'mail' : 1
            " \}
" " }}}

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
