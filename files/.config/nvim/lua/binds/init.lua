-- vim: ft=lua
-- leader
vim.g.mapleader = " "
vim.g.maplocaleader = " "

-- window movement
vim.keymap.set("n", "<A-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>")

-- insert newlines above or below without entering insert mode
vim.keymap.set("n", "<CR>", "o<Esc>")
vim.keymap.set("n", "<A-CR>", "O<Esc>")

-- make Y behave like the rest of the capital letters
vim.keymap.set("n", "Y", "y$")

-- keep buffer centered on search result browsing
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- absolutely bananans text movement shennanigans holy guacamole
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==")
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")

-- keystroke reduction for saving quitting and savequitting
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<A-q>", ":q<CR>")
vim.keymap.set("n", "<A-Q>", ":qa<CR>")
vim.keymap.set("n", "<A-x>", ":x<CR>")

-- splits
vim.keymap.set("n", "<A-;>", ":vsp<CR>")
vim.keymap.set("n", "<A-'>", ":sp<CR>")

-- movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- indentation
vim.keymap.set("n", "<Tab>", ">>_")
vim.keymap.set("n", "<S-Tab>", "<<_")
vim.keymap.set("v", "<Tab>", ">")
vim.keymap.set("v", "<S-Tab>", "<")

-- LSP
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>dd", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>du", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>sdf", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>sdc", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>si", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<leader>st", vim.lsp.buf.type_definition, {})
vim.keymap.set("n", "<leader>sr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ss", vim.lsp.buf.signature_help, {})

-- tabs
vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')
vim.keymap.set('n', '<A-P>', '<Cmd>BufferPin<CR>')
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')

-- Gitsigns
vim.keymap.set("n", "<leader>gd", '<Cmd>Gitsigns diffthis<CR>')
vim.keymap.set("n", "<leader>gtb", '<Cmd>Gitsigns toggle_current_line_blame<CR>')
