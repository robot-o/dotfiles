local ts = require('telescope.builtin')
local actions = require("telescope.actions")

require('telescope').setup {
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
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

vim.keymap.set('n', '<A-/>', ts.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<A-d>', ts.find_files, {})
vim.keymap.set('n', '<A-f>', ts.live_grep, {})
vim.keymap.set('n', '<A-F>', ts.grep_string, {})
vim.keymap.set('n', '<A-b>', ts.buffers, {})
vim.keymap.set('n', '<A-p>', ts.command_history, {})
vim.keymap.set('n', '<A-P>', ts.builtin, {})
vim.keymap.set("n", "<leader>s", '', { desc = 'Telescope..' })
vim.keymap.set("n", "<leader>sg", '', { desc = 'Telescope/git..' })
vim.keymap.set("n", "<leader>sgc", '', { desc = 'Commits' })
vim.keymap.set("n", "<leader>sgb", '', { desc = 'Branches' })
vim.keymap.set("n", "<leader>sl", '', { desc = 'Telescope/LSP..' })
vim.keymap.set("n", "<leader>slr", '', { desc = 'References' })
vim.keymap.set("n", "<leader>sld", '', { desc = 'Diagnostics' })
vim.keymap.set("n", "<leader>slf", '', { desc = 'Definitions' })
vim.keymap.set("n", "<leader>sli", '', { desc = 'Implementations' })
vim.keymap.set("n", "<leader>sls", '', { desc = 'Symbols' })

