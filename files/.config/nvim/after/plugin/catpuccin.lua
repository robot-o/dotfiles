require('auto-dark-mode').setup({
  update_interval = 3000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')
  end,
  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')
  end,
})

require("catppuccin").setup({
  flavour = "mocha",   -- latte, frappe, macchiato, mocha
  background = {       -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,   -- disables setting the background color.
  show_end_of_buffer = false,       -- shows the '~' characters after the end of buffers
  term_colors = false,              -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true,                -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.1,              -- percentage of the shade to apply to the inactive window
  },
  no_italic = false,                -- Force no italic
  no_bold = false,                  -- Force no bold
  no_underline = false,             -- Force no underline
  styles = {                        -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" },        -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    barbar = true,
    mini = false,
    mason = true,
    telescope = { enabled = true },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
