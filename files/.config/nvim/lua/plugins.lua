-- vim: ft=lua

-- init packer
vim.cmd('packadd packer.nvim')

-- packer definitions
return require('packer').startup(
  function()
    use 'nvim-lua/plenary.nvim'
    use {
      'nvim-treesitter',
      run = ':TSUpdate'
    }
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-telescope/telescope.nvim'
    use 'romgrk/barbar.nvim'
    use 'joshdick/onedark.vim'
    use 'preservim/nerdtree'
    use 'nvim-lualine/lualine.nvim'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'preservim/nerdcommenter'
    use 'pearofducks/ansible-vim'
    use 'Yggdroot/indentLine'
    use 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    use 'sheerun/vim-polyglot'
  )

-- plugin specific options 
vim.g.fzf_layout = {'window': { 'width': 0.8, 'height': 0.8 } }

-- startup
require('lualine').setup {
  options = {
    theme = 'onedark'
  }
}
