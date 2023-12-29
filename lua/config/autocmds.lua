-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.b.autoformat = false
  end,
})

autocmd("LspAttach", {
  callback = function()
    require("config.lsp-settings")
  end,
})

autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = false
  end,
})

autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = true
  end,
})
