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
nnoremap <silent> <A-s> :w<CR>
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
nnoremap <A-u> :UndotreeToggle<CR>
nnoremap <A-e> :NERDTreeToggle<CR>
nnoremap <A-p> :Commands<CR>
nnoremap <A-o> :!
nnoremap <A-d> :Files<CR>
nnoremap <A-r> :History:<CR>
nnoremap <A-f> :Rg<Space>

" Git
nnoremap <leader>gs :vertical G<CR>
nnoremap <leader>gl :Gclog<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gds :Git diff --staged<CR>
nnoremap <leader>gdw :Git diff --word-diff<CR>
nnoremap <leader>gdsw :Git diff --staged --word-diff<CR>
nnoremap <leader>gco :GCheckout<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpull<CR>
nnoremap <leader>gps :Gpush<CR>
nnoremap <leader>gm :Git merge<Space>
nnoremap <leader>gmh :diffget //2<CR>
nnoremap <leader>gml :diffget //3<CR>

" tabs & spaces
set expandtab
set tabstop=8
set softtabstop=-1
set shiftwidth=2
set smartindent
set autoindent

" UI Config
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

" misc
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
if has('vim')
  set ttymouse=xterm2
endif
set mouse=a
filetype plugin on

" Install vim-plug if not found
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

" actual plugins definitions
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" commentedc out because it's bugged currently https://github.com/junegunn/fzf.vim/issues/1008
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'pearofducks/ansible-vim'
Plug 'Yggdroot/indentLine'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'sheerun/vim-polyglot'
call plug#end()

" plugin config
let g:fzf_layout = {'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:NERDDefaultAlign = 'left'

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" colors
" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
colorscheme onedark
let g:airline#extensions#tabline#enabled = 1
let g:airline_extensions = []
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:coc_global_extensions = [
      \ 'coc-pairs',
      \ 'coc-diagnostic',
      \ 'coc-marketplace',
      \ 'coc-html',
      \ '@yaegassy/coc-ansible',
      \ 'coc-yaml',
      \ 'coc-pyright',
      \ 'coc-omnisharp',
      \ 'coc-json',
      \ 'coc-groovy',
      \ 'coc-docker',
      \ 'coc-webview',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-markdownlint',
      \ 'coc-toml',
      \ 'coc-sql',
      \ 'coc-go',
      \ 'coc-css',
			\ 'coc-rls'
      \ ]

