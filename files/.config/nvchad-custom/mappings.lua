local M = {}

    -- [""] = { "" },

M.general = {
  n = {
    ["<leader>j"] = { ":m .+1<CR>==", "move line down" },
    ["<leader>k"] = { ":m .-2<CR>==", "move line up" },
    ["n"] = { "nzzzv", "keep buffer centered on search result browsing" },
    ["N"] = { "Nzzzv", "keep buffer centered on search result browsing" },
    ["Y"] = { "y$", "make Y behave like the rest of the capital letters" },
    ["<CR>"] = { "o<Esc>", "insert newlines above or below without entering insert mode" },
    ["<A-CR>"] = { "O<Esc>", "insert newlines above or below without entering insert mode" },
    ["<A-;>"] = { "<cmd> :vsp<CR>", "vertical split" },
    ["<A-'>"] = { "<cmd> :sp<CR>", "horizontal split" },
    ["<C-n>"] = { "<cmd> enew <CR>", "烙 new buffer" },
    ["<A-w>"] = {
       function()
          require("core.utils").close_buffer()
       end,
       "   close buffer",
    },
    ["<A-q>"] = { "<cmd> :q<CR>", "close window" },
    ["<A-Q>"] = { "<cmd> :qa<CR>", "close all windows" },
    ["<A-x>"] = { "<cmd> :x<CR>", "save and close window (:wq)" },
  },

  i = {
    ["<C-j>"] = { "<cmd> :m .+1<CR>", "move entire cursor line down" },
    ["<C-k>"] = { "<cmd> :m .-2<CR>", "move entire cursor line up" },
    ["<C-a>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },
  },

  v = {
    ["<C-j>"] = { "<cmd> :m '>+1<CR>gv=gv", "move entire cursor line down"  },
    ["<C-k>"] = { "<cmd> :m '<-2<CR>gv=gv", "move entire cursor line up"  },
  },
}

M.telescope = {
  n = {
    ["<A-d>"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<A-f>"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
  },
}

M.comment = {
   n = {
      ["<C-/>"] = {
         function()
            require("Comment.api").toggle_current_linewise()
         end,
         "蘒  toggle comment",
      },
   },

   v = {
      ["<C-/>"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "蘒  toggle comment",
      },
   },
}

return M
