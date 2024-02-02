-- vim: ft=lua

HOME = os.getenv('HOME')

-- # settings
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.nu = true
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
vim.opt.scrolloff = 16
vim.opt.conceallevel = 0
vim.opt.tabstop = 8
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = 'yes'
vim.opt.mouse = 'a'
vim.opt.undodir = vim.fn.expand('~/.cache/nvim_undodir')

-- # keybinds
vim.g.mapleader = " "
vim.g.maplocaleader = " "
-- splits
vim.keymap.set("n", "<A-;>", ":vsp<CR>")
vim.keymap.set("n", "<A-'>", ":sp<CR>")
-- split/window movement
vim.keymap.set("n", "<A-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>")
-- insert newlines above or below without entering insert mode
vim.keymap.set("n", "<CR>", "o<Esc>")
vim.keymap.set("n", "<A-CR>", "O<Esc>")
-- make Y behave like the rest of the capital letters
vim.keymap.set("n", "Y", "y$")
-- copy to system clip
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y$")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>Y", "\"+y$")
-- paste from system clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>P", "\"+P")
-- keep buffer centered on search result browsing
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- absolutely bananans text movement shennanigans holy guacamole
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==")
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
-- keystroke reduction for saving quitting and savequitting
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<A-q>", ":q<CR>")
vim.keymap.set("n", "<A-Q>", ":qa<CR>")
vim.keymap.set("n", "<A-x>", ":x<CR>")
-- movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
-- indentation
vim.keymap.set("n", "<Tab>", ">>_")
vim.keymap.set("n", "<S-Tab>", "<<_")
vim.keymap.set("v", "<Tab>", ">")
vim.keymap.set("v", "<S-Tab>", "<")
-- LSP
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, {})
vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>dd", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>du", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>sdf", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>sdc", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>si", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<leader>st", vim.lsp.buf.type_definition, {})
vim.keymap.set("n", "<leader>sr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ss", vim.lsp.buf.signature_help, {})
-- tabs
vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')
vim.keymap.set('n', '<A-P>', '<Cmd>BufferPin<CR>')
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
-- Gitsigns
vim.keymap.set("n", "<leader>gd", '<Cmd>Gitsigns diffthis<CR>')
vim.keymap.set("n", "<leader>gtb", '<Cmd>Gitsigns toggle_current_line_blame<CR>')

-- plugins

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use { "catppuccin/nvim", as = "catppuccin" }
  use('mbbill/undotree')
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- null-ls replacement
      { 'nvimtools/none-ls.nvim' },
      -- custom LSPs
      { 'jose-elias-alvarez/typescript.nvim' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }
  use('nvim-tree/nvim-web-devicons')
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }
  use('lewis6991/gitsigns.nvim')
  use { 'romgrk/barbar.nvim', wants = { 'nvim-web-devicons', 'gitsigns.nvim' } }
  use('f-person/auto-dark-mode.nvim')
  use('lukas-reineke/indent-blankline.nvim')
  if packer_bootstrap then
    require('packer').sync()
  end
end)
