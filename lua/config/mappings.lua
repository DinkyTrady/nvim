vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, map, mapdo)
  vim.api.nvim_set_keymap(mode, map, mapdo, { noremap = true, silent = true })
end

map("n", "<leader>x", "<Cmd>bd<Cr>")

map("n", "H", "<Cmd>bn<Cr>")
map("n", "L", "<Cmd>bp<Cr>")

map("n", "<ScrollWheelUp>", "<C-y><C-y><C-y><C-y><C-y>")
map("n", "<ScrollWheelDown>", "<C-e><C-e><C-e><C-e><C-e>")

-- lsp
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<Cr>")
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<Cr>")
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<Cr>")
map("n", "zi", "<Cmd>lua vim.lsp.buf.implementation()<Cr>")
map("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<Cr>")
map("n", "<leader>cf", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>")
map("n", "<leader>cF", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>")
map("n", "<leader>D", "<Cmd>lua vim.lsp.buf.type_definition()<Cr>")
map("n", "<leader>cr", "<Cmd>lua vim.lsp.buf.rename()<Cr>")
map("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<Cr>")
map("n", "gr", "<Cmd>lua vim.lsp.buf.references()<Cr>")
map("n", "<leader>lf", "<Cmd>lua vim.lsp.buf.format({ async = false, timeout_ms = 2000 })<Cr>")
map("n", "<leader>cd", "<Cmd>lua vim.diagnostic.open_float()<Cr>")
map("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<Cr>")
map("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<Cr>")
map("n", "<leader>d", "<Cmd>lua vim.diagnostic.setloclist()<Cr>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- insert mode
map("i", "<A-k>", "<Esc>v:m .-2<CR>==gi")
map("i", "<A-j>", "<Esc>v:m .+1<CR>==gi")

-- visual mode
map("v", "K", ":m .-2<CR>gv")
map("v", "J", ":m .+1<CR>gv")

-- visual-line mode
map("x", "K", ":m .-2<CR>gv")
map("x", "J", ":m .+1<CR>gv")
