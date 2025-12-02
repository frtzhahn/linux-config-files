" ------------------------------
" Basic Settings
" ------------------------------
syntax on                  " Enable syntax highlighting
set number                 " Show line numbers
set relativenumber         " Show relative numbers
set cursorline             " Highlight current line
set showcmd                " Show incomplete commands
set showmatch              " Highlight matching brackets
set hlsearch               " Highlight search results
set incsearch              " Incremental search
set ignorecase smartcase   " Case-insensitive search unless capitals
set tabstop=4              " Number of spaces per tab
set shiftwidth=4           " Number of spaces per indentation
set expandtab              " Use spaces instead of tabs
set autoindent             " Auto-indent new lines
set smartindent            " Smarter indentation
set clipboard=unnamedplus  " Use system clipboard
set mouse=a                " Enable mouse support

" ------------------------------
" File Backup & Undo
" ------------------------------
set undofile               " Persistent undo
set backup                 " Keep backup files
set backupdir=~/.vim/backup//  " Backup directory
set directory=~/.vim/swap//    " Swapfile directory

" ------------------------------
" Appearance
" ------------------------------
colorscheme desert         " Simple colorscheme (change if you like)
set termguicolors          " Enable true color
set showmode               " Show current mode

" ------------------------------
" Key mappings
" ------------------------------
" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Save quickly
nnoremap <leader>w :w<CR>

" Quit quickly
nnoremap <leader>q :q<CR>

" ------------------------------
" Plugins (with vim-plug)
" ------------------------------
call plug#begin('~/.vim/plugged')

" File explorer
Plug 'preservim/nerdtree'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Status line
Plug 'itchyny/lightline.vim'

" Syntax / Treesitter (Neovim only)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" ------------------------------
" Plugin settings
" ------------------------------
" NERDTree toggle
nnoremap <leader>n :NERDTreeToggle<CR>

" Lightline theme
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" FZF key mapping
nnoremap <C-p> :Files<CR>




