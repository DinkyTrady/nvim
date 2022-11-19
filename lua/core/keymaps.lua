local opt = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--fast to normal mode with 'jj'
map("i", "jj", "<esc>", opt)
map("s", "jj", "<esc>", opt)
map("v", "jk", "<esc>", opt)
--
map("v", "<C-Up>", ":m .-2<CR>==", opt)
map("v", "<C-Down>", ":m .+1<CR>==", opt)

--To another tab & pick tab or close it
map("n", "<tab>", ":bnext<CR>", opt)
map("n", "<bs>", ":bprev<CR>", opt)

--To another window
map("n", "<C-h>", "<C-w>h<CR>", opt)
map("n", "<C-l>", "<C-w>l<CR>", opt)
map("n", "<C-j>", "<C-w>j<CR>", opt)
map("n", "<C-k>", "<C-w>k<CR>", opt)

--ToggleTerm
map("n", "<C-t>", ":ToggleTerm<CR>", opt)
