-- vim: ft=lua
-- env vars
HOME = os.getenv('HOME')
FZF_DEFAULT_OPTS = '--reverse'

-- globals
vim.g.mapleader = ' '
vim.g.NERDDefaultAlign = 'left'

-- bools
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.incsearch = true
vim.opt.nohlsearch = true
vim.opt.smartcase = true
vim.opt.noswapfile = true
vim.opt.nobackup = true
vim.opt.undofile = true
vim.opt.syntax = true

-- vals
vim.opt.scrolloff = 16
vim.opt.conceallevel = 0
vim.opt.tabstop = 8
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = 80

-- strs
vim.opt.signcolumn = 'yes'
vim.opt.mouse = 'a'
vim.opt.undodir = '~/.config/nvim/undodir'
vim.opt.clipboard += 'unnamedplus'

