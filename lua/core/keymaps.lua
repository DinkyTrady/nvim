local opt = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--fast to normal mode with 'jj'
map("i", "jj", "<esc>", opt)
map("s", "jj", "<esc>", opt)
map("v", "jk", "<esc>", opt)

--Move word in visual mode
map("v", "<C-Up>", ":m .-2<CR>==", opt)
map("v", "<C-Down>", ":m .+1<CR>==", opt)

-- Resize pane
map("n", "<C-Up>", ":resize -2<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)

--To another tab & pick tab or close it
map("n", "<tab>", ":bnext<CR>", opt)
map("n", "<bs>", ":bprev<CR>", opt)

--To another window
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)

--make terminal split or vertical
map("n", "<C-t>", ":ToggleTerm<cr>", opt)

-- undo an redo in insert mode
map("i", "<C-u>", "<esc>ui", opt)
map("i", "<C-r>", "<esc><C-r><esc>i", opt)
