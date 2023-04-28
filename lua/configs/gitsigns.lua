local M = {}

M.config = {
	"lewis6991/gitsigns.nvim",
	-- event = "BufReadPre",
	init = function()
		require("core.commands").lazyload("gitsigns.nvim")
	end,
	config = function()
		require("configs.gitsigns").setup()
	end,
}

function M.setup()
	local status, gitsigns = pcall(require, "gitsigns")
	if not status then
		return
	end

	gitsigns.setup({
		signs = {
			add = { hl = "GitSignsAdd", text = "▊", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "▊", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "▁", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "▁", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = {
				hl = "GitSignsChange",
				text = "▊",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 500,
		},
		current_line_blame_formatter = "   <author>, <author_time:%c> - <summary>",
	})
end

return M
