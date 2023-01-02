local ts = require('telescope.builtin')
ts.setup {
  pickers = {
    find_files = {
      hidden = true
    }
  }
}
vim.keymap.set('n', '<A-d>', ts.find_files, {})
vim.keymap.set('n', '<A-f>', ts.live_grep, {})
vim.keymap.set('n', '<A-b>', ts.buffers, {})
