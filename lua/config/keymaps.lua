-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local map = Util.safe_keymap_set

map("i", "<C-h>", "<LEFT>", { desc = "Move cursor to left" })
map("i", "<C-j>", "<DOWN>", { desc = "Move cursor to down" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor to up", remap = true })
map("i", "<C-l>", "<RIGHT>", { desc = "Move cursor to right" })

map({ "n", "x" }, "<leader>h", ":noh<cr>", { desc = "Remove search highlight" })

map("n", "<leader>r", ":set rnu!<cr>", { desc = "Relative Number toggle" })

map("n", "<leader>gg", function()
  require("lazyvim.util").terminal.open(
    { "gitui" },
    { cwd = require("lazyvim.util").root.get(), esc_esc = false, ctrl_hjkl = false }
  )
end, { desc = "gitui (root dir)" })
map("n", "<leader>gG", function()
  require("lazyvim.util").terminal.open(
    { "gitui" },
    { cwd = require("lazyvim.util").root.get(), esc_esc = false, ctrl_hjkl = false }
  )
end, { desc = "gitui (root dir)" })

map("n", "<ScrollWheelUp>", "<C-y><C-y><C-y><C-y><C-y>")
map("n", "<ScrollWheelDown>", "<C-e><C-e><C-e><C-e><C-e>")

-- vim.keymap.del("n", "<leader>gg")
-- vim.keymap.d;el("n", "<leader>gG")
