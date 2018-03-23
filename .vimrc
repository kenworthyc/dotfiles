execute pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on
syntax enable

set nocompatible               " Mystery vim optimizations over vi
set modelines=0								 " Mystery security gap vanquished

"set esc to jj
:imap jj <Esc>
"send Normal commands without the Shift key
nmap ; :

set number                     " enable line numbers
set noswapfile                 " Do not create swap files
set undofile									 " Keep track of undo changes after file close
set scrolloff=2                " offsets scrolling by two lines at bottom/top of page
set sidescrolloff=5            " offsets horizontal scrolling by 5 chars
set backspace=indent,eol,start " backspace over EOL in insert mode
set autoread                   " vim will auto-reload a changed file instead of ask what to do
au FocusGained,BufEnter * :checktime " reread file whenever you change focus to a file
set ttyfast
set ruler
set wildmenu
set wildmode=longest:full,full
set cursorline

" set clipboard to system, while not in tmux
if $TMUX == ''
  set clipboard+=unnamed
endif

"searching
set hlsearch
set ignorecase "ignore case when searching
set smartcase "if you include an uppercase while searching, become case sensitive
set incsearch "show search matches as you type
set gdefault "Apply substitutions globally on a line

"tabs based on filetype
"by default, the indent is 2 spaces.
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
"for html/erb, markdown/yaml files, 2 spaces
autocmd Filetype ruby,html,erb setlocal ts=2 sw=2 expandtab
"for js/coffee files, 4 spaces
autocmd Filetype javascript,coffeescript setlocal ts=4 sw=4 sts=0 expandtab

"remove trailing whitespace on save
autocmd BufWritePre <buffer> :%s/\s\+$//e

"leaders
let mapleader = "\<Space>"
nnoremap <leader><leader> :wa<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <C-]> :tabnext<CR>

"easily clear highlighted items from search
nmap <leader>cl :nohlsearch<CR>

"Enter newlines from normal mode
nmap <CR> o<Esc>

"navigate to panes
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"flip background between light and dark
" map <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

"font and colorschemes
set background=dark
colorscheme base16-railscasts
nmap <leader>mo :colorscheme base16-monokai<CR>
nmap <leader>so :colorscheme base16-solarized-dark<CR>
nmap <leader>at :colorscheme base16-atelier-dune<CR>

set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline:h16
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'html.twig' : 1,
    \}

"syntastic beginner settings
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ["vim-twig"]

"set emmet to HTML/CSS files
let g:user_emmet_install_global = 1
autocmd FileType html,css,erb EmmetInstall
let g:user_emmet_leader_key='<C-e>'

"enable indent guides
let g:indent_guides_enable_on_vim_startup = 1

"enable ctrl-p fuzzyfinder
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <leader>o :CtrlP<CR>

"airline settings
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
set laststatus=2 " makes airline work pre split
let g:airline#extensions#tabline#enabled = 1 " make tabs show all the time
let g:airline#extensions#tabline#left_sep = ' ' "change tab appearance
let g:airline#extensions#tabline#left_alt_sep = '|' "Change tab appearance
let g:airline#extensions#syntastic#enabled = 1

