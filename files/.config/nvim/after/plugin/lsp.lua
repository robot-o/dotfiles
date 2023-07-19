local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- language server setup 
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.skip_server_setup({'tsserver'})

lsp.setup()

require('typescript').setup({
  server = {
    settings = {
      diagnostics = {
        ignoredCodes = { 80001, 7016 },
      },
    },
    on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>tsi', '<cmd>TypescriptAddMissingImports<cr>', {buffer = bufnr})
    end,
  },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
    {name = 'path'},
  },
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  },
})
