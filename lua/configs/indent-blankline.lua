local M = {}

M.config = {
	"lukas-reineke/indent-blankline.nvim",
	-- event = "BufRead",
	init = function()
		require("core.commands").lazyload("indent-blankline.nvim")
	end,
	config = function()
		require("configs.indent-blankline").setup()
	end,
}

function M.setup()
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
end

return M
