-- vim: ft=lua

-- fix for barbar
vim.api.nvim_create_autocmd('Colorscheme', {
    group = vim.api.nvim_create_augroup('config_custom_highlights', {}),
    callback = function()
      -- Override colorscheme settings before the colorscheme 'load()' call
      vim.api.nvim_set_hl(0, 'BufferCurrentADDED',   {bg = '#202329', fg = '#7EA662'})
      vim.api.nvim_set_hl(0, 'BufferCurrentCHANGED', {bg = '#202329', fg = '#4FA6ED'})
      vim.api.nvim_set_hl(0, 'BufferCurrentDELETED', {bg = '#202329', fg = '#E55561'})
      vim.api.nvim_set_hl(0, 'BufferCurrentERROR', {bg = '#202329', fg = '#E55561'})
      vim.api.nvim_set_hl(0, 'BufferCurrentWARN', {bg = '#202329', fg = '#E55561'})
    end,
})

require('onedark').setup {
    style = 'darker',
    transparent = false,
}
require('onedark').load()

