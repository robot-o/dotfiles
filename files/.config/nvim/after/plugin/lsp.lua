local lsp_zero = require('lsp-zero').preset({})
lsp_zero.extend_lspconfig()

-- null-ls setup
local null_ls = require("null-ls")
local null_ls_opts = lsp_zero.build_options('null-ls', {})
null_ls.setup({
  on_attach = function(client, bufnr)
    null_ls_opts.on_attach(client, bufnr)
  end,
  sources = {
    -- comp
    null_ls.builtins.completion.luasnip,
    -- actions
    -- fmt
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.hclfmt,
    null_ls.builtins.formatting.yamlfmt,
    -- diag
    null_ls.builtins.diagnostics.markdownlint,
  },
})

-- configure integration with mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'clangd',
    'nil_ls',
  },
  -- configure custom lsp settings here
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    clangd = function()
      require('lspconfig').clangd.setup {}
    end,
    nil_ls = function()
      require('lspconfig').nil_ls.setup ({
        settings = {
          ['nil'] = {
            formatting = {
              command = { "nixfmt" },
            }
          }
        }
      })
    end,
  },
})

-- completion
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

cmp.setup({
  formatting = cmp_format,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'path' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }),
})
