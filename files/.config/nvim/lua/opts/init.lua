-- vim: ft=lua
-- env vars
HOME = os.getenv('HOME')

-- globals
vim.g.mapleader = ' '

-- bools
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.nu= true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- vals
vim.opt.scrolloff = 16
vim.opt.conceallevel = 0
vim.opt.tabstop = 8
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80"

-- strs
vim.opt.signcolumn = 'yes'
vim.opt.mouse = 'a'
vim.opt.undodir = '~/.cache/nvim_undodir'

