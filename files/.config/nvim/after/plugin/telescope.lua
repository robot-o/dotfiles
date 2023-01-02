require('telescope').setup{
  pickers = {
    find_files = {
      hidden = true
    },
    live_grep = {
      additional_args = function(opts)
        return {"--hidden"}
      end
    }
  }
}
local ts = require('telescope.builtin')
vim.keymap.set('n', '<A-d>', ts.find_files, {})
vim.keymap.set('n', '<A-f>', ts.live_grep, {})
vim.keymap.set('n', '<A-b>', ts.buffers, {})
