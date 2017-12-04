source ~/.config/nvim/plugins.vim

" Section General {{{

set nocompatible            " not compatible with vi
set autoread                " detect when a file is changed

set history=1000            " change history to 1000
set textwidth=120


" }}}

" Section User Interface {{{

syntax on

" enable 24 bit color support if supported
if (has("termguicolors"))
    set termguicolors
endif

colorscheme onedark


set number                  " show line numbers

set wrap                    " turn on line wrapping
set wrapmargin=8            " wrap lines when coming within n characters from side
set linebreak               " set soft wrapping
set showbreak=…             " show ellipsis at breaking

set autoindent              " automatically set indent of new line
set smartindent

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" make backspace behave in a sane manner
set backspace=indent,eol,start

filetype plugin indent on

" code folding settings
set foldmethod=syntax       " fold based on indent
set foldlevelstart=99
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
set foldlevel=1

set shell=$SHELL
set cmdheight=1             " command bar height
set title                   " set terminal title

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set incsearch               " set incremental search, like modern browsers
set nolazyredraw            " don't redraw while executing macros

set wildignorecase          " case insensitive file opening

set magic                   " Set magic on, for regex

set showmatch               " show matching braces
set mat=2                   " how many tenths of a second to blink

" error bells
set noerrorbells
set visualbell
set t_vb=
set tm=500

" }}}

" Section Mappings {{{

" set a map leader for more key combos
let mapleader = ','

" }}}


" Section Plugins {{{

" airline options
let g:airline_theme='onedark'

" don't hide quotes in json files
let g:vim_json_syntax_conceal = 0

" }}}
