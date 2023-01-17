-- credits to @Malace : https://www.reddit.com/r/neovim/comments/ql4iuj/rename_hover_including_window_title_and/
-- This is modified version of the above snippet

local M = {}

M.open = function()
  local currName = vim.fn.expand("<cword>") .. " "

  local win = require("plenary.popup").create(currName, {
    title = "New Name",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "FloatBorder",
    titlehighlight = "Title",
    focusable = true,
    width = 25,
    height = 0,
    line = "cursor+2",
    col = "cursor-1",
  })

  local map_opts = { noremap = true, silent = true }

  local keymap = vim.api.nvim_buf_set_keymap

  vim.cmd("normal w")
  vim.cmd("normal gH")

  keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  keymap(0, "n", "q", "<cmd>stopinsert | q!<CR>", map_opts)
  keymap(0, "s", "<Esc>", "<ESC>:q!<CR>", map_opts)

  keymap(
    0,
    "i",
    "<CR>",
    "<cmd>stopinsert | lua require'others.rename'.apply(" .. currName .. "," .. win .. ")<CR>",
    map_opts
  )

  keymap(
    0,
    "n",
    "<CR>",
    "<cmd>stopinsert | lua require'others.rename'.apply(" .. currName .. "," .. win .. ")<CR>",
    map_opts
  )
end

M.apply = function(curr, win)
  local newName = vim.trim(vim.fn.getline("."))
  vim.api.nvim_win_close(win, true)

  if #newName > 0 and newName ~= curr then
    local params = vim.lsp.util.make_position_params()
    params.newName = newName

    vim.lsp.buf_request(0, "textDocument/rename", params)
  end
end

return M
