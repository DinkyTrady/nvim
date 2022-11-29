local map = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--vim.api.nvim_set_keymap("n", "<leader>ll", ":lua vim.lsp.buf.format({timeout_ms = 2000})")

-- Change mode
map("i", "jj", "<esc>")
map("s", "jj", "<esc>")
map("v", "jk", "<esc>")

--better moving for window to window
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

--Move word in visual mode
map("v", "<C-Up>", ":m .-2<CR>==")
map("v", "<C-Down>", ":m .+1<CR>==")

-- map("n", "<leader>", ":WhichKey<cr><leader>")

-- reload files not work in blanl file!
map("n", "<leader>r", ":so%<cr>")
map("n", "<leader>qq", ":q<cr>")

-- Resize pane
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Fast another tabs
map("n", "<TAB>", ":bnext<cr>")
map("n", "<BS>", ":bprev<cr>")

-- to explore with NeoTree
map("n", "<leader>e", ":NeoTreeRevealToggle<cr>")
map("n", "<leader>t", ":NeoTreeFloatToggle<cr>")

-- Close cureent buffers
map("n", "<leader>x", ":bdelete!<cr>")

-- Activate colorizer
map("n", "<leader>c", ":ColorizerToggle<cr>")

-- Teleacope mappings
map("n", "<leader>ft", ":Telescope<cr>")
map("n", "<leader>ff", ":Telescope find_files<cr>")
map("n", "<leader>fo", ":Telescope oldfiles<cr>")
map("n", "<leader>fb", ":Telescope buffers<cr>")
map("n", "<leader>fk", ":Telescope keymaps<cr>")
map("n", "<leader>fc", ":Telescope colorscheme<cr>")
map("n", "<leader>fd", ":Telescope file_browser<cr>")

-- PackerCommands
map("n", "<leader>ps", ":PackerSync<cr>")
map("n", "<leader>pS", ":PackerStatus<cr>")
map("n", "<leader>pc", ":PackerCompile<cr>")
map("n", "<leader>pC", ":PackerClean<cr>")

-- Float - terminal with Lspsaga
map("n", "<C-t>", [[:Lspsaga open_floaterm<cr>]])
map("t", "jj", [[<C-\><C-n>]])
map("t", "<C-t>", [[<C-\><C-n>:Lspsaga close_floaterm<cr>]])
