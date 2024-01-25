local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- actions
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.completion.spell,
    null_ls.builtins.completion.tags,
    -- diagnostics
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    -- formatting
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.cbfmt,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.terraform_fmt,
  },
})
