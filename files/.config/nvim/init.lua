-- vim: ft=lua
-- install & init lazy
HOME = os.getenv('HOME')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- options

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
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.scrolloff = 32
vim.opt.conceallevel = 0
vim.opt.tabstop = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = 'yes'
vim.opt.mouse = 'a'
vim.opt.undodir = vim.fn.expand('~/.cache/nvim_undodir')
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.g.mapleader = " "
vim.g.maplocaleader = " "


if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font:h12"
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_window_blurred = true
  vim.g.neovide_show_border = false
  vim.g.neovide_input_macos_option_key_is_meta = 'both'
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_trail_size = 0.1
end

-- plugins
require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      enabled = true,
      lazy = false,
      priority = 1000,
      opts = {
        transparent = true,
      },
    },
    {
      "grafana/vim-alloy",
      enabled = true,
    },
    {
      "folke/snacks.nvim",
      enabled = true,
      priority = 1000,
      lazy = false,
      opts = {
        animate = {
          enabled = false,
          duration = 10,
          easing = "linear",
          fps = 120,
        },
        bigfile = {
          enabled = true,
          notify = true,
          size = 2 * (1024 * 1024) -- 2MB
        },
        bufdelete = { enabled = false },
        dashboard = { enabled = true },
        debug = { enabled = true },
        dim = { enabled = true },
        explorer = {
          enabled = true,
          replace_netrw = true
        },
        git = { enabled = false },
        gitbrowse = { enabled = false },
        image = { enabled = true },
        indent = {
          enabled = true,
          animate = { enabled = false }
        },
        input = { enabled = true },
        layout = { enabled = true },
        lazygit = { enabled = true },
        notifier = { enabled = true },
        notify = { enabled = true },
        picker = { enabled = true },
        profiler = { enabled = false },
        quickfile = { enabled = true },
        rename = { enabled = false },
        scope = { enabled = true },
        scratch = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        terminal = { enabled = true },
        toggle = { enabled = true },
        util = { enabled = true },
        win = { enabled = true },
        words = { enabled = true },
        zen = { enabled = true },
      },
      keys = {
        { "<A-e>",            mode = { "n" }, function() Snacks.explorer({ hidden = true, exclude = { "**/.git" } }) end,     desc = "Picker/Explorer" },
        { "<leader>z",        mode = { "n" }, function() Snacks.zen() end,                                                    desc = "ZenMode Toggle" },
        { "<A-g>",            mode = { "n" }, function() Snacks.lazygit.open() end,                                           desc = "Lazygit" },
        { "<leader><leader>", mode = { "n" }, function() Snacks.picker.files({ hidden = true, exclude = { "**/.git" } }) end, desc = "Picker/Files" },
        { "<A-d>",            mode = { "n" }, function() Snacks.picker.files({ hidden = true, exclude = { "**/.git" } }) end, desc = "Picker/Files" },
        { "<A-r>",            mode = { "n" }, function() Snacks.picker.recent() end,                                          desc = "Picker/Recent" },
        { "<A-f>",            mode = { "n" }, function() Snacks.picker.grep() end,                                            desc = "Picker/Grep" },
        { "<A-n>",            mode = { "n" }, function() Snacks.picker.notifications() end,                                   desc = "Picker/Notifications" },
        { "<A-p>",            mode = { "n" }, function() Snacks.picker.command_history() end,                                 desc = "Picker/CommandHistory" },
        { "<A-P>",            mode = { "n" }, function() Snacks.picker.commands() end,                                        desc = "Picker/Commands" },
        { "<leader>lD",       mode = { "n" }, function() Snacks.picker.diagnostics() end,                                     desc = "Picker/Diagnostics" },
        {
          "<A-o>",
          mode = { "n" },
          function()
            Snacks.input.input({ prompt = "command: " }, function(input)
              if input then
                vim.cmd("!" .. input)
              end
            end)
          end,
          desc = "Input/Command"
        },
        {
          "<A-O>",
          mode = { "n" },
          function()
            Snacks.input.input({ prompt = "command into buffer: " }, function(input)
              if input then
                vim.cmd("r!" .. input)
              end
            end)
          end,
          desc = "Input/CommandIntoBuffer"
        },
        { "<leader><leader>", mode = { "n" },           function() Snacks.picker.files({ hidden = true, exclude = { "**/.git" } }) end, desc = "Picker/Files" },
        { "<A-`>",            mode = { "n", "i", "t" }, function() Snacks.terminal.toggle() end,                                        desc = "Terminal/Toggle" },
        { "<leader>tt",       mode = { "n", "i", "t" }, function() Snacks.terminal.toggle() end,                                        desc = "Terminal/Toggle" },
        { "<A-h>",            mode = { "t" },           "<C-\\><C-n>:wincmd h<CR>" },
        { "<A-j>",            mode = { "t" },           "<C-\\><C-n>:wincmd j<CR>" },
        { "<A-k>",            mode = { "t" },           "<C-\\><C-n>:wincmd k<CR>" },
        { "<A-l>",            mode = { "t" },           "<C-\\><C-n>:wincmd l<CR>" },
        { "<esc><esc>",       mode = { "t" },           "<C-\\><C-n>" },
        { '<A-q>',            mode = { 't' },           "<C-\\><C-n>:q<CR>" },
      },
    },
    {
      "folke/flash.nvim",
      enabled = false,
      event = "VeryLazy",
      opts = {},
      keys = {
        { "<leader>sj", mode = { "n", "x", "o", "t" }, function() require("flash").jump() end,              desc = "Flash: Jump" },
        { "<leader>st", mode = { "n", "x", "o", "t" }, function() require("flash").treesitter() end,        desc = "Flash: Treesitter" },
        { "<leader>sr", mode = { "o" },                function() require("flash").remote() end,            desc = "Flash: Remote" },
        { "<leader>sR", mode = { "o", "x" },           function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },
        { "<leader>sT", mode = { "c" },                function() require("flash").toggle() end,            desc = "Flash: Toggle" },
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      enabled = true,
      lazy = false,
      branch = 'master',
      build = ':TSUpdate',
      opts = {
        ensure_installed = {
          "bash",
          "zsh",
          "python",
          "go",
          "rust",
          "gdscript",
          "gdshader",
          "godot_resource",
          "terraform",
          "hcl",
          "nix",
          "ninja",
          "ini",
          "regex",
          "css",
          "html",
          "javascript",
          "vue"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "yaml" },
        },
      },
      dependencies = {
        { "OXY2DEV/markview.nvim", },
      },
    },
    {
      'mason-org/mason-lspconfig.nvim',
      enabled = true,
      lazy = false,
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "LspInfo", "LspInstall", "LspUninstall" },
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
      opts = {
        automatic_enable = true,
        ensure_installed = { 'lua_ls' },
      }
    },
    {
      'stevearc/conform.nvim',
      enabled = true,
      lazy = true,
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        { "<leader>f", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
      },
      opts = {
        formatters_by_ft = {
          kdl = { "kdlfmt" },
          gdscript = { "gdformat" },
        },
      },
    },
    {
      'mfussenegger/nvim-lint',
      enabled = true,
      lazy = true,
      event = { "BufWritePost", "BufReadPost", "InsertLeave" },
      config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
          sh = { 'shellcheck' },
        }
      end,
    },
    {
      'saghen/blink.cmp',
      enabled = true,
      lazy = false,
      event = { "InsertEnter", },
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
      version = '1.*',
      opts = {
        keymap = { preset = 'super-tab' },
        appearance = { nerd_font_variant = 'mono' },
        completion = { documentation = { auto_show = true } },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    {
      "j-hui/fidget.nvim",
      enabled = true,
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
      version = "v1.6.1"
    },
    {
      'nvim-lualine/lualine.nvim',
      enabled = true,
      lazy = true,
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', file_status = true, newfile_status = false, path = 1 } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      },
      dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
      'romgrk/barbar.nvim',
      enabled = true,
      lazy = true,
      event = { "BufReadPost", "BufNewFile" },
      keys = {
        { '<A-w>', '<Cmd>BufferClose<CR>' },
        { '<A-W>', '<Cmd>BufferCloseAllButVisible<CR>' },
        { '<A-1>', '<Cmd>BufferGoto 1<CR>' },
        { '<A-2>', '<Cmd>BufferGoto 2<CR>' },
        { '<A-3>', '<Cmd>BufferGoto 3<CR>' },
        { '<A-4>', '<Cmd>BufferGoto 4<CR>' },
        { '<A-5>', '<Cmd>BufferGoto 5<CR>' },
        { '<A-6>', '<Cmd>BufferGoto 6<CR>' },
        { '<A-7>', '<Cmd>BufferGoto 7<CR>' },
        { '<A-8>', '<Cmd>BufferGoto 8<CR>' },
        { '<A-9>', '<Cmd>BufferGoto 9<CR>' },
        { '<A-0>', '<Cmd>BufferLast<CR>' },
        { '<A-=>', '<Cmd>BufferPin<CR>' },
        { '<A-->', '<Cmd>BufferPick<CR>' },
        { '<A-[>', '<Cmd>BufferPrevious<CR>' },
        { '<A-]>', '<Cmd>BufferNext<CR>' },
        { '<A-{>', '<Cmd>BufferMovePrevious<CR>' },
        { '<A-}>', '<Cmd>BufferMoveNext<CR>' },
      },
      dependencies = {
        { "nvim-tree/nvim-web-devicons", opts = {} },
        {
          'lewis6991/gitsigns.nvim',
          keys = {
            { "<leader>g",   '',                                            desc = 'Git..' },
            { "<leader>gd",  '<Cmd>Gitsigns diffthis<CR>',                  desc = 'diff' },
            { "<leader>gtb", '<Cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'toggle line blame' },
          },
          opts = {
            signs                        = {
              add          = { text = '│' },
              change       = { text = '│' },
              delete       = { text = '_' },
              topdelete    = { text = '‾' },
              changedelete = { text = '~' },
              untracked    = { text = '┆' },
            },
            signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
              follow_files = true
            },
            attach_to_untracked          = true,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
              virt_text = true,
              virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
              delay = 1000,
              ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil,   -- Use default
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            preview_config               = {
              -- Options passed to nvim_open_win
              border = 'single',
              style = 'minimal',
              relative = 'cursor',
              row = 0,
              col = 1
            },
          },
        }
      },
      opts = {
        animation = false,
        auto_hide = false,
        tabpages = true,
        clickable = true,
        icons = {
          diagnostics = { enabled = false, },
          gitsigns = { enabled = false, },
          filetype = {
            enabled = false,
            custom_colors = true,
          },
          button = '⛌',
          buffer_index = true,
          buffer_number = false,
          separator = { left = '▏', right = '', },
          inactive = { separator = { left = '▏', }, },
          separator_at_end = false,
          modified = { button = '●', },
          pinned = { button = '📌', },
        },
        exclude_ft = nil,
        exclude_name = nil,
        hide = { extensions = false, inactive = false },
        highlight_alternate = false,
        highlight_visible = true,
        insert_at_end = true,
        insert_at_start = false,
        maximum_padding = 1,
        minimum_padding = 1,
        maximum_length = 30,
        semantic_letters = true,
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
        no_name_title = '[new]',
      },
    },
    {
      "stevearc/oil.nvim",
      enabled = true,
      keys = {
        { "<leader>e", function() require('oil').toggle_float() end },
        { "<A-E>",     function() require('oil').toggle_float() end },
      },
      opts = {
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        buf_options = {
          buflisted = true,
        },
        view_options = {
          show_hidden = true,
        },
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<A-;>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
          ["<A-'>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["<A-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
          ["<A-p>"] = "actions.preview",
          ["<A-e>"] = "actions.close",
          ["<A-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      },
    },
    {
      "folke/which-key.nvim",
      enabled = true,
      opts = {},
    },
  },
  install = { colorscheme = { "tokyonight" } },
  checker = {
    enabled = true,
    notify = false
  },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.cmd.highlight { 'BufferVisibleIndex', 'guifg=#a9b1d6' }
    vim.cmd.highlight { 'BufferCurrent', 'guifg=#2ac3de' }
    vim.cmd.highlight { 'BufferCurrentSign', 'guifg=#565f89' }
    vim.cmd.highlight { 'BufferCurrentSignRight', 'guifg=#565f89' }
    vim.cmd.highlight { 'BufferVisibleSign', 'guifg=#565f89' }
    vim.cmd.highlight { 'BufferVisibleSignRight', 'guifg=#565f89' }
    vim.cmd.highlight { 'BufferInactiveSign', 'guifg=#565f89' }
    vim.cmd.highlight { 'BufferInactiveSignRight', 'guifg=#565f89' }
  end,
})

vim.cmd.colorscheme "tokyonight"


-- custom filetypes

vim.filetype.add({
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
  },
  pattern = {
    ['.*.tfvars'] = function(path)
      if path:match("[/\\]tofu[/\\]") then
        return "opentofu-vars"
      end
    end,
    ['.*.tf'] = function(path)
      if path:match("[/\\]tofu[/\\]") then
        return "opentofu"
      end
    end,
    ['.*.ya?ml'] = function(path)
      if path:match("[/\\]ansible[/\\]") then
        return "yaml.ansible"
      end
    end,
    ['.*.j2'] = function(ext)
      if ext:match('ya?ml') then
        return 'yaml.jinja'
      else
        return 'jinja'
      end
    end,
  },
})

-- custom magic
-- godot
local gd_paths    = { '/', '/../' }
local gd_is_prj   = false
local gd_prj_path = ''
local gd_cwd      = vim.fn.getcwd()

for _, v in pairs(gd_paths) do
  if vim.uv.fs_stat(gd_cwd .. v .. 'project.godot') then
    gd_is_prj = true
    gd_prj_path = gd_cwd .. v
    break
  end
end

local gd_srv_run = vim.uv.fs_stat(gd_prj_path .. '/server.pipe')
if gd_is_prj and not gd_srv_run then
  vim.fn.serverstart(gd_prj_path .. '/server.pipe')
end


-- additional lsp magic
-- vim.lsp.config('nil_ls', { settings = { formatting = { command = { "alejandra" } } } })
vim.lsp.enable({ 'nil_ls', 'bashls', 'yamlls', 'gdscript' })

-- enable inline diagnostics
vim.diagnostic.config({ virtual_text = true })

-- keymaps

vim.keymap.set("n", "<A-;>", ":vsp<CR>")
vim.keymap.set("n", "<A-'>", ":sp<CR>")

vim.keymap.set("n", "<A-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<CR>", "o<Esc>")
vim.keymap.set("n", "<A-CR>", "O<Esc>")

vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "<leader>y", "\"+y", { desc = 'Text: yank from system clipboard' })
vim.keymap.set("n", "<leader>Y", "\"+y$", { desc = 'Text: yank line from system clipboard' })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = 'Text: yank from system clipboard' })
vim.keymap.set("v", "<leader>Y", "\"+y$", { desc = 'Text: yank line from system clipboard' })
vim.keymap.set("n", "<leader>p", "\"+p", { desc = 'Text: paste down from system clipboard' })
vim.keymap.set("n", "<leader>P", "\"+P", { desc = 'Text: paste up from system clipboard' })
vim.keymap.set("v", "<leader>p", "\"+p", { desc = 'Text: paste down from system clipboard' })
vim.keymap.set("v", "<leader>P", "\"+P", { desc = 'Text: paste up from system clipboard' })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-J>", "<esc>:m .+1<CR>==")
vim.keymap.set("i", "<A-K>", "<esc>:m .-2<CR>==")
vim.keymap.set("n", "<A-J>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-K>", ":m .-2<CR>==")

vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<A-q>", ":q<CR>")
vim.keymap.set("n", "<A-Q>", ":qa<CR>")
vim.keymap.set("n", "<A-x>", ":x<CR>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<Tab>", ">>_")
vim.keymap.set("n", "<S-Tab>", "<<_")
vim.keymap.set("v", "<Tab>", ">")
vim.keymap.set("v", "<S-Tab>", "<")

vim.keymap.set("n", "<leader>l", '', { desc = 'LSP...' })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = 'format' })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = 'rename' })
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = 'hover' })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = 'code action' })
vim.keymap.set("n", "<leader>ld", '', { desc = 'diagnostics..' })
vim.keymap.set("n", "<leader>ldf", vim.diagnostic.open_float, { desc = 'open float' })
vim.keymap.set("n", "<leader>ldd", function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'goto next' })
vim.keymap.set("n", "<leader>ldu", function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'goto previous' })
vim.keymap.set("n", "<leader>ls", '', { desc = 'symbols..' })
vim.keymap.set("n", "<leader>lsd", vim.lsp.buf.definition, { desc = 'goto definition' })
vim.keymap.set("n", "<leader>lsD", vim.lsp.buf.declaration, { desc = 'goto declaration' })
vim.keymap.set("n", "<leader>lsi", vim.lsp.buf.implementation, { desc = 'goto implementation' })
vim.keymap.set("n", "<leader>lst", vim.lsp.buf.type_definition, { desc = 'goto type definition' })
vim.keymap.set("n", "<leader>lsr", vim.lsp.buf.references, { desc = 'show references' })
vim.keymap.set("n", "<leader>lss", vim.lsp.buf.signature_help, { desc = 'signature help' })
