local opt = { noremap = true, silent = true }

local map = vim.keymap.set

map("", '<Space>', '<Nop>', opt)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '



--open nvim-tree with 'space + t'
map('n', '<leader>t', ':NvimTreeToggle<CR>', opts)

--For save click 'space + w', save and quit click 'wq', quit neovim click 'space + q', to force quit click 'fq' in normal mode, and reset neovim use 'space + s'
map('n', '<leader>w', ':w<CR>', opt)
map('n', 'wq', ':wq<CR>', opt)
map('n', '<leader>q', ':q<CR>', opt)
map('n', 'fq', ':q!<CR>', opt)
map('n', '<leader>s', ':so<CR>', opt)

  --To another tab & pick tab or close it
map('n', '<C-l>', ':BufferLineCycleNext<CR>', opt)
map('n', '<C-h>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<leader>p', ':BufferLinePick<CR>', opt)
map('n', '<leader>y', ':BufferLinePickClose<CR>', opt)

--Telescope
map('n', '<leader>ft', '<cmd>Telescope<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
