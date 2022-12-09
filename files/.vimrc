" annyoing autohide bullshit
set conceallevel=0

" leader
let mapleader = ' '

" use system clipboard
set clipboard+=unnamedplus

" window movements
nnoremap <A-h> :wincmd h<CR>
nnoremap <A-j> :wincmd j<CR>
nnoremap <A-k> :wincmd k<CR>
nnoremap <A-l> :wincmd l<CR>

" insert newlines above or below without entering insert mode
nnoremap <CR> o<Esc>
nnoremap <A-CR> O<Esc>

" make Y behave like the rest of the capital letters
nnoremap Y y$

" keep buffer centered on search result browsing
nnoremap n nzzzv
nnoremap N Nzzzv

" absolutely bananans text movement shennanigans holy guacamole
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" keystroke reduction for saving quitting and savequitting
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <A-q> :q<CR>
nnoremap <silent> <A-Q> :qa<CR>
nnoremap <silent> <A-x> :x<CR>

" testin
" tabs
nnoremap <silent>    <A-t> :tabnew<CR> 
nnoremap <silent>    <A-w> :BufferClose<CR>
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferGoto 9<CR>
nnoremap <silent>    <A-0> :BufferGoto 10<CR>

" splits
nnoremap <A-;> :vsp<CR>
nnoremap <A-'> :sp<CR>

" panels / tools
nnoremap <A-p> :Commands<CR>
nnoremap <A-o> :!
nnoremap <A-d> :Files<CR>
nnoremap <A-r> :History:<CR>

" tabs & spaces
set expandtab
set tabstop=2
set softtabstop=-1
set shiftwidth=2
set smartindent
set autoindent

" UI Config
syntax on
set relativenumber
set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set colorcolumn=80
set signcolumn=yes
highlight ColorColumn ctermbg=0 guibg=lightgrey
set splitright
set scrolloff=16

" Searching
set incsearch
set nohlsearch
set smartcase

" Movement
nnoremap j gj
nnoremap k gk


" janitorial work
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

if has('vim')
  set ttymouse=xterm2
endif

set mouse=a
filetype plugin on

if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" PLUGINS

if has('nvim')
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
else
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
endif

call plug#begin('~/.vim/plugged')
Plug 'navarasu/onedark.nvim'
call plug#end()
" Vim
let g:onedark_config = {
    \ 'style': 'warmer',
\}
colorscheme onedark
