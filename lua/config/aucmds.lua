local aucmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd

aucmd("FileType", {
	pattern = { "qf", "help" },
	callback = function()
		vim.keymap.set("n", "q", "<Cmd>bd!<Cr>")
	end,
})

aucmd("BufRead", {
	pattern = "*",
	callback = function()
		cmd([[call setpos(".", getpos("'\""))]])
	end,
})

aucmd("VimResized", {
	callback = function()
		cmd("wincmd=")
	end,
})

aucmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Search", timeout = "100" })
	end,
})
