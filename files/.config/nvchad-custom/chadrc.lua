local M = {}

M.options = {
   user = function()
       require("custom.options")
   end,
}

M.mappings = require "custom.mappings"

M.ui = {
   theme = "onedark",
}

M.plugins = {
  override = {
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "yaml",
        "python",
        "go",
        "lua",
        "c_sharp",
        "c",
        "cpp",
        "dockerfile",
        "glsl",
        "graphql",
        "hcl",
        "html",
        "css",
        "javascript",
        "json",
        "jsonc",
        "make",
        "markdown",
        "nix",
        "rust",
        "sql",
      },
    },
  },
  user = {
    ["towolf/vim-helm"] = {},
  }
}

return M
