-- vim: ft=lua
HOME = os.getenv('HOME')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_show_border = false
  vim.g.neovide_input_macos_option_key_is_meta = 'both'
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_trail_size = 0.1
end

require("lazy").setup({
  spec = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.1,
        },
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
        },
      },
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      -- stylua: ignore
      keys = {
        { "<leader>sj", mode = { "n", "x", "o", "t" }, function() require("flash").jump() end,              desc = "Flash: Jump" },
        { "<leader>st", mode = { "n", "x", "o", "t" }, function() require("flash").treesitter() end,        desc = "Flash: Treesitter" },
        { "<leader>sr", mode = { "o" },                function() require("flash").remote() end,            desc = "Flash: Remote" },
        { "<leader>sR", mode = { "o", "x" },           function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },
        { "<leader>sT", mode = { "c" },                function() require("flash").toggle() end,            desc = "Flash: Toggle" },
      },
    },
    {
      'nvim-telescope/telescope.nvim',
      version = '0.1.x',
      dependencies = { { 'nvim-lua/plenary.nvim' } },
      opts = function()
        local actions = require("telescope.actions")
        return {
          pickers = {
            find_files = {
              find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
            live_grep = {
              additional_args = function()
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
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts = {
        ensure_installed = {
          "arduino",
          "bash",
          "c_sharp",
          "cpp",
          "css",
          "diff",
          "dockerfile",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "glsl",
          "go",
          "gomod",
          "graphql",
          "hcl",
          "html",
          "json",
          "jsonc",
          "latex",
          "make",
          "markdown",
          "nix",
          "regex",
          "rst",
          "scss",
          "sql",
          "toml",
          "vim",
          "yaml",
          "javascript",
          "python",
          "c",
          "lua",
          "rust" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "yaml" },
        },
      },
    },
    { 'mbbill/undotree' },
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim', opts = {}, },
    {
      'williamboman/mason-lspconfig.nvim',
      opts = {
        ensure_installed = {
          'lua_ls',
        },
      }
    },
    {
      'nvimtools/none-ls.nvim',
      opts = function()
        local null_ls = require('null-ls')
        return {
          sources = {
            null_ls.builtins.completion.luasnip,
            null_ls.builtins.formatting.shellharden,
            null_ls.builtins.formatting.hclfmt,
            null_ls.builtins.formatting.yamlfmt,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.diagnostics.markdownlint,
          }
        }
      end
    },
    {
      -- TODO: switch to blink.cmp
      'hrsh7th/nvim-cmp',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'saadparwaiz1/cmp_luasnip' },
      },
      opts = function()
        local cmp = require('cmp')
        local ls = require('luasnip')
        return {
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer',  keyword_length = 3 },
            { name = 'luasnip', keyword_length = 2 },
            { name = 'path' },
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                if ls.expandable() then
                  ls.expand()
                else
                  cmp.confirm({ select = true, })
                end
              else
                fallback()
              end
            end),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif ls.locally_jumpable(1) then
                ls.jump(1)
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif ls.locally_jumpable(-1) then
                ls.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<C-f>'] = cmp.mapping(function(fallback)
              if ls.locally_jumpable(1) then
                ls.jump(1)
              else
                fallback()
              end
            end),
            ['<C-b>'] = cmp.mapping(function(fallback)
              if ls.locally_jumpable(-1) then
                ls.jump(-1)
              else
                fallback()
              end
            end),
          }),
        }
      end
    },
    {
      "j-hui/fidget.nvim",
      opts = {},
      version = "v1.3.0"
    },
    {
      'nvim-tree/nvim-tree.lua',
      enabled = false,
      keys = {
        { "<A-R>", ":NvimTreeToggle<CR>" },
        { "<A-r>", ":NvimTreeFocus<CR>" },
        { "<A-U>", ":UndotreeToggle<CR>" },
        { "<A-u>", ":UndotreeFocus<CR>" },
      },
      opts = {
        disable_netrw = false,
        hijack_netrw = true
      },
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
    },
    {
      'nvim-lualine/lualine.nvim',
      opts = {
        options = {
          icons_enabled = true,
          theme = 'catppuccin',
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
      dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },
    {
      'lewis6991/gitsigns.nvim',
      keys = {
        { "<leader>lc",  '<Cmd>ClangdSwitchSourceHeader<CR>',           desc = 'clangd: toggle source/header' },
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
    },
    {
      'romgrk/barbar.nvim',
      lazy = false,
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
      dependencies = { 'nvim-web-devicons', 'gitsigns.nvim' },
      opts = {
        animation = false,
        auto_hide = false,
        tabpages = true,
        closable = true,
        clickable = true,
        icons = {
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = false },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = false },
          },
          gitsigns = {
            added = { enabled = false, icon = '+' },
            changed = { enabled = false, icon = '~' },
            deleted = { enabled = false, icon = '-' },
          },
          filetype = {
            enabled = true,
            custom_colors = true,
          },
          button = 'X',
          separator = { left = '▎', right = '', },
          inactive = { separator = { left = '▎', right = '', }, },
          modified = { button = '●', },
          pinned = { button = '📌', },
        },
        exclude_ft = { '' },
        exclude_name = { '' },
        hide = { extensions = false, inactive = false },
        highlight_alternate = false,
        highlight_visible = true,
        insert_at_end = false,
        insert_at_start = true,
        maximum_padding = 1,
        minimum_padding = 1,
        maximum_length = 30,
        semantic_letters = true,
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
        no_name_title = nil,
      },
    },
    {
      'f-person/auto-dark-mode.nvim',
      opts = {
        update_interval = 3000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value('background', 'dark', {})
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value('background', 'light', {})
        end,
      },
    },
    {
      "stevearc/oil.nvim",
      keys = {
        { "<A-E>", ":Oil<CR>" },
        { "<A-e>", function()
          require('oil').open_float()
        end },
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
      'akinsho/toggleterm.nvim',
      keys = {
        { mode = "n", "<A-`>",      '<Cmd>ToggleTerm<CR>',                      desc = 'Terminal: toggle' },
        { mode = "i", "<A-`>",      '<Cmd>ToggleTerm<CR>',                      desc = 'Terminal: toggle' },
        { mode = "t", "<A-`>",      '<Cmd>ToggleTerm<CR>',                      desc = 'Terminal: toggle' },
        { mode = "n", "<leader>t",  '',                                         desc = 'Terminal..' },
        { mode = "n", "<leader>tt", '<Cmd>ToggleTerm<CR>',                      desc = 'toggle' },
        { mode = "n", "<leader>tv", '<Cmd>ToggleTerm direction=vertical<CR>',   desc = 'toggle vertical' },
        { mode = "n", "<leader>th", '<Cmd>ToggleTerm direction=horizontal<CR>', desc = 'toggle horizontal' },
        { mode = "n", "<leader>tf", '<Cmd>ToggleTerm direction=float<CR>',      desc = 'toggle float' },
        { mode = "n", "<leader>tT", '<Cmd>ToggleTerm direction=tab<CR>',        desc = 'toggle tab' },
        { mode = "t", "<A-h>",      "<C-\\><C-n>:wincmd h<CR>" },
        { mode = "t", "<A-j>",      "<C-\\><C-n>:wincmd j<CR>" },
        { mode = "t", "<A-k>",      "<C-\\><C-n>:wincmd k<CR>" },
        { mode = "t", "<A-l>",      "<C-\\><C-n>:wincmd l<CR>" },
        { mode = "t", "<esc><esc>", "<C-\\><C-n>" },
        { mode = 't', '<A-q>',      "<C-\\><C-n>:q<CR>" },
      },
      opts = {
        insert_mappings = true,
        terminal_mappings = true,
        hide_numbers = false,
        winbar = {
          enabled = false,
        },
        env = {
          ZSH_KEYBIND_MODE = "v",
        },
        size = function(term)
          if term.direction == "horizontal" then
            return 25
          end
          if term.direction == "vertical" then
            return 100
          end
        end,
        float_opts = {
          border = 'curved',
          width = 160,
          height = 40,
        }
      },
    },
    { "folke/which-key.nvim",              opts = {}, },
    {
      "folke/zen-mode.nvim",
      keys = {
        { "<leader>z", '<Cmd>ZenMode<CR>', desc = 'ZenMode: Toggle' },
      },
      opts = {
        width = 200,
      },
    },
    { 'pearofducks/ansible-vim' },
    {
      'robitx/gp.nvim',
      enabled = true,
      keys = {
        { mode = "n", "<leader>a",    '',                             desc = 'AI...' },
        { mode = "n", "<leader>ac",   '',                             desc = 'Chat...' },
        { mode = "n", "<leader>acc",  '<Cmd>GpChatToggle<CR>',        desc = 'toggle' },
        { mode = "n", "<leader>acd",  '<Cmd>GpChatDelete<CR>',        desc = 'delete' },
        { mode = "n", "<leader>acf",  '<Cmd>GpChatFinder<CR>',        desc = 'finder' },
        { mode = "n", "<leader>ach",  '<Cmd>GpChatToggle split<CR>',  desc = 'toggle (hsplit)' },
        { mode = "n", "<leader>acv",  '<Cmd>GpChatToggle vsplit<CR>', desc = 'toggle (vsplit)' },
        { mode = "n", "<leader>act",  '<Cmd>GpChatToggle tabnew<CR>', desc = 'toggle (new tab)' },
        { mode = "n", "<leader>acP",  '<Cmd>GpChatToggle popup<CR>',  desc = 'toggle (popup)' },
        { mode = "v", "<leader>ac",   '',                             desc = 'Chat (with selection context)...' },
        { mode = "v", "<leader>acc",  '<Cmd>GpChatToggle<CR>',        desc = 'toggle (with selection context)' },
        { mode = "v", "<leader>ach",  '<Cmd>GpChatToggle split<CR>',  desc = 'toggle (hsplit) (with selection context)' },
        { mode = "v", "<leader>acv",  '<Cmd>GpChatToggle vsplit<CR>', desc = 'toggle (vsplit) (with selection context)' },
        { mode = "v", "<leader>act",  '<Cmd>GpChatToggle tabnew<CR>', desc = 'toggle (new tab) (with selection context)' },
        { mode = "v", "<leader>acp",  '<Cmd>GpChatToggle popup<CR>',  desc = 'toggle (popup) (with selection context)' },
        { mode = "n", "<leader>acp",  '<Cmd>GpChatPaste<CR>',         desc = 'paste selection' },
        { mode = "n", "<leader>acph", '<Cmd>GpChatPaste split<CR>',   desc = 'paste selection (hsplit)' },
        { mode = "n", "<leader>acpv", '<Cmd>GpChatPaste vsplit<CR>',  desc = 'paste selection (vsplit)' },
        { mode = "n", "<leader>acpt", '<Cmd>GpChatPaste tabnew<CR>',  desc = 'paste selection (new tab)' },
        { mode = "n", "<leader>acpp", '<Cmd>GpChatPaste popup<CR>',   desc = 'paste selection (popup)' },
        { mode = "v", "<leader>acp",  '<Cmd>GpChatPaste<CR>',         desc = 'paste selection' },
        { mode = "v", "<leader>acph", '<Cmd>GpChatPaste split<CR>',   desc = 'paste selection (hsplit)' },
        { mode = "v", "<leader>acpv", '<Cmd>GpChatPaste vsplit<CR>',  desc = 'paste selection (vsplit)' },
        { mode = "v", "<leader>acpt", '<Cmd>GpChatPaste tabnew<CR>',  desc = 'paste selection (new tab)' },
        { mode = "v", "<leader>acpp", '<Cmd>GpChatPaste popup<CR>',   desc = 'paste selection (popup)' },
        { mode = "n", "<leader>at",   '',                             desc = 'Text..' },
        { mode = "n", "<leader>atr",  '<Cmd>GpRewrite<CR>',           desc = 'Rewrite' },
        { mode = "n", "<leader>ata",  '<Cmd>GpAppend<CR>',            desc = 'Append' },
        { mode = "n", "<leader>atp",  '<Cmd>GpPrepend<CR>',           desc = 'Prepend' },
        { mode = "n", "<leader>atb",  '<Cmd>GpEnew<CR>',              desc = 'Rewrite (new buffer)' },
        { mode = "n", "<leader>att",  '<Cmd>GpTabnew<CR>',            desc = 'Rewrite (new tab)' },
        { mode = "n", "<leader>ath",  '<Cmd>GpNew<CR>',               desc = 'Rewrite (hsplit)' },
        { mode = "n", "<leader>atv",  '<Cmd>GpVnew<CR>',              desc = 'Rewrite (vsplit)' },
        { mode = "n", "<leader>ato",  '<Cmd>GpPopup<CR>',             desc = 'Rewrite (popup)' },
        { mode = "n", "<leader>atc",  '<Cmd>GpContext<CR>',           desc = 'Set Repository Context' },
        { mode = "v", "<leader>at",   '',                             desc = 'Text..(selection)' },
        { mode = "v", "<leader>atr",  [[:<C-u>GpRewrite<CR>]],        desc = 'Rewrite (selection)' },
        { mode = "v", "<leader>ata",  [[:<C-u>GpAppend<CR>]],         desc = 'Append (selection)' },
        { mode = "v", "<leader>atp",  [[:<C-u>GpPrepend<CR>]],        desc = 'Prepend (selection)' },
        { mode = "v", "<leader>atb",  [[:<C-u>GpEnew<CR>]],           desc = 'Rewrite (new buffer) (selection)' },
        { mode = "v", "<leader>att",  [[:<C-u>GpTabnew<CR>]],         desc = 'Rewrite (new tab) (selection)' },
        { mode = "v", "<leader>ath",  [[:<C-u>GpNew<CR>]],            desc = 'Rewrite (hsplit) (selection)' },
        { mode = "v", "<leader>atv",  [[:<C-u>GpVnew<CR>]],           desc = 'Rewrite (vsplit) (selection)' },
        { mode = "v", "<leader>ato",  [[:<C-u>GpPopup<CR>]],          desc = 'Rewrite (popup) (selection)' },
        { mode = "v", "<leader>atc",  [[:<C-u>GpContext<CR>]],        desc = 'Set Repository Context (selection)' },
      },
      opts = {
        providers = {
          openai = {
            disable = false,
            endpoint = "https://api.openai.com/v1/chat/completions",
            secret = { "bw-get.sh", "OPENAI_API_KEY" },
          },
          ollama = {
            disable = true,
            endpoint = "http://localhost:11434/v1/chat/completions",
          },
        },
        agents = {
          {
            provider = "openai",
            name = "chat-4.1",
            chat = true,
            command = false,
            model = {
              model = "gpt-4.1",
              temperature = 1.1,
              top_p = 1,
            },
            system_prompt =
            "You are a highly capable AI assistant specialized in software development, dev ops, cloud architecture, system architecture, and debugging. Answer concisely and practically. Ask clarifying questions if required to optimize answer quality.",
          },
          {
            provider = "openai",
            name = "code-4.1",
            chat = false,
            command = true,
            model = {
              model = "gpt-4.1",
              temperature = 0.7,
              top_p = 1,
            },
            system_prompt =
            "You are an AI working as a code editor. Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE. START AND END YOU ANSWER WITH THREE BACKTICKS.",
          },
          {
            provider = "openai",
            name = "chat-4.1-mini",
            chat = true,
            command = false,
            model = {
              model = "gpt-4.1-mini",
              temperature = 1.1,
              top_p = 1,
            },
            system_prompt =
            "You are a highly capable AI assistant specialized in software development, dev ops, cloud architecture, system architecture, and debugging. Answer concisely and practically. Ask clarifying questions if required to optimize answer quality.",
          },
          {
            provider = "openai",
            name = "code-4.1-mini",
            chat = false,
            command = true,
            model = {
              model = "gpt-4.1-mini",
              temperature = 0.7,
              top_p = 1,
            },
            system_prompt =
            "You are an AI working as a code editor. Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE. START AND END YOU ANSWER WITH THREE BACKTICKS.",
          },
          {
            provider = "openai",
            name = "chat-o4-mini",
            chat = true,
            command = false,
            model = {
              model = "o4-mini",
              temperature = 1.1,
              top_p = 1,
            },
            system_prompt =
            "You are a highly capable AI assistant specialized in software development, dev ops, cloud architecture, system architecture, and debugging. Answer concisely and practically. Ask clarifying questions if required to optimize answer quality.",
          },
          {
            provider = "openai",
            name = "code-o4-mini",
            chat = false,
            command = true,
            model = {
              model = "o4-mini",
              temperature = 0.7,
              top_p = 1,
            },
            system_prompt =
            "You are an AI working as a code editor. Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE. START AND END YOU ANSWER WITH THREE BACKTICKS.",
          },
          {
            provider = "openai",
            name = "chat-o3-mini",
            chat = true,
            command = false,
            model = {
              model = "o3-mini",
              temperature = 1.1,
              top_p = 1,
            },
            system_prompt =
            "You are a highly capable AI assistant specialized in software development, dev ops, cloud architecture, system architecture, and debugging. Answer concisely and practically. Ask clarifying questions if required to optimize answer quality.",
          },
          {
            provider = "openai",
            name = "code-o3-mini",
            chat = false,
            command = true,
            model = {
              model = "o3-mini",
              temperature = 0.7,
              top_p = 1,
            },
            system_prompt =
            "You are an AI working as a code editor. Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE. START AND END YOU ANSWER WITH THREE BACKTICKS.",
          },
          {
            provider = "openai",
            name = "chat-o3",
            chat = true,
            command = false,
            model = {
              model = "o3",
              temperature = 1.1,
              top_p = 1,
            },
            system_prompt =
            "You are a highly capable AI assistant specialized in software development, dev ops, cloud architecture, system architecture, and debugging. Answer concisely and practically. Ask clarifying questions if required to optimize answer quality.",
          },
          {
            provider = "openai",
            name = "code-o3",
            chat = false,
            command = true,
            model = {
              model = "o3",
              temperature = 0.7,
              top_p = 1,
            },
            system_prompt =
            "You are an AI working as a code editor. Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE. START AND END YOU ANSWER WITH THREE BACKTICKS.",
          },
        },
        whisper = { disable = true, },
        image = { disable = true, },
        default_chat_agent = "chat-4.1",
        default_command_agent = "code-4.1",
        chat_dir = vim.fn.expand('$HOME/Documents/ollama/nvim'),
      },
    },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = {
    enabled = true,
    notify = false
  },
})

vim.cmd.colorscheme "catppuccin"

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
vim.keymap.set("n", "<leader>ldl", vim.diagnostic.setloclist, { desc = 'open list' })
vim.keymap.set("n", "<leader>lds", vim.diagnostic.open_float, { desc = 'open float' })
vim.keymap.set("n", "<leader>ldd", vim.diagnostic.goto_next, { desc = 'goto next' })
vim.keymap.set("n", "<leader>ldu", vim.diagnostic.goto_prev, { desc = 'goto prev' })
vim.keymap.set("n", "<leader>ls", '', { desc = 'symbols..' })
vim.keymap.set("n", "<leader>lsd", vim.lsp.buf.definition, { desc = 'goto definition' })
vim.keymap.set("n", "<leader>lsD", vim.lsp.buf.declaration, { desc = 'goto declaration' })
vim.keymap.set("n", "<leader>lsi", vim.lsp.buf.implementation, { desc = 'goto implementation' })
vim.keymap.set("n", "<leader>lst", vim.lsp.buf.type_definition, { desc = 'goto type definition' })
vim.keymap.set("n", "<leader>lsr", vim.lsp.buf.references, { desc = 'show references' })
vim.keymap.set("n", "<leader>lss", vim.lsp.buf.signature_help, { desc = 'signature help' })

local ts = require('telescope.builtin')
vim.keymap.set('n', '<leader>/', ts.current_buffer_fuzzy_find, { desc = 'Telescope: fuzzy find current buffer' })
vim.keymap.set('n', '<leader>d', ts.find_files, { desc = 'Telescope: find files' })
vim.keymap.set('n', '<leader>f', ts.live_grep, { desc = 'Telescope: live grep' })
vim.keymap.set('n', '<leader>F', ts.grep_string, { desc = 'Telescope: grep string' })
vim.keymap.set('n', '<leader>b', ts.buffers, { desc = 'Telescope: buffers' })
vim.keymap.set('n', '<leader>o', ts.command_history, { desc = 'Telescope: command history' })
vim.keymap.set('n', '<A-/>', ts.current_buffer_fuzzy_find, { desc = 'Telescope: ' })
vim.keymap.set('n', '<A-d>', ts.find_files, {})
vim.keymap.set('n', '<A-f>', ts.live_grep, {})
vim.keymap.set('n', '<A-F>', ts.grep_string, {})
vim.keymap.set('n', '<A-b>', ts.buffers, {})
vim.keymap.set('n', '<A-p>', ts.command_history, {})
vim.keymap.set('n', '<A-P>', ts.builtin, {})
vim.keymap.set("n", "<leader>S", '', { desc = 'Telescope..' })
vim.keymap.set("n", "<leader>Sg", '', { desc = 'Git..' })
vim.keymap.set("n", "<leader>Sgc", '', { desc = 'Commits' })
vim.keymap.set("n", "<leader>Sgb", '', { desc = 'Branches' })
vim.keymap.set("n", "<leader>Sl", '', { desc = 'LSP..' })
vim.keymap.set("n", "<leader>Slr", '', { desc = 'References' })
vim.keymap.set("n", "<leader>Sld", '', { desc = 'Diagnostics' })
vim.keymap.set("n", "<leader>Slf", '', { desc = 'Definitions' })
vim.keymap.set("n", "<leader>Sli", '', { desc = 'Implementations' })
vim.keymap.set("n", "<leader>Sls", '', { desc = 'Symbols' })
