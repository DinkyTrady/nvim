vim.opt.list = true
vim.opt.listchars:append("eol:↴")

local blankline_ok, blankline = pcall(require, "indent_blankline")
if not blankline_ok then
	return
end

blankline.setup({
	show_current_context = true,
	show_current_context_start = true,
	show_end_of_line = true,
})
