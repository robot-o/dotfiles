local ts = require('telescope.builtin')
local actions = require("telescope.actions")

require('telescope').setup {
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      -- find_command = { "fd", "--hidden", "--type", "f", "--strip-cwd-prefix" },
    },

    live_grep = {
      additional_args = function(opts)
        return { "--hidden" }
      end
    }
  },

  defaults = {
    mappings = {
      i = {
        ["<A-;>"] = actions.select_vertical,
        ["<A-'>"] = actions.select_horizontal,
        ["<A-t>"] = actions.select_tab
      },

      n = {
        ["<A-;>"] = actions.select_vertical,
        ["<A-'>"] = actions.select_horizontal,
        ["<A-t>"] = actions.select_tab
      }
    }
  }
}

vim.keymap.set('n', '<A-d>', ts.find_files, {})
vim.keymap.set('n', '<A-f>', ts.live_grep, {})
vim.keymap.set('n', '<A-b>', ts.buffers, {})
vim.keymap.set('n', '<A-o>', ts.commands, {})
vim.keymap.set('n', '<A-p>', ts.command_history, {})
