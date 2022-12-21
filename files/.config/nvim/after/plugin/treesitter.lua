-- vim: ft=lua

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "help", "arduino", "bash", "c_sharp", "cpp", "css", "diff", "dockerfile", "git_rebase", "gitattributes", "gitcommit", "gitignore", "glsl", "go", "gomod", "graphql", "hcl", "hlsl", "html", "json", "jsonc", "jsonnet", "latex", "make", "markdown", "nix", "perl", "php", "rasi", "regex", "rst", "scss", "sql", "toml", "vim", "yaml", "javascript", "python", "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
