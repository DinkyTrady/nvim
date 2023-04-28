local M = {
	config = {
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "TermExec", "ToggleTerm" },
		config = function()
			require("configs.term").setup()
		end,
	},
	setup = function()
		require("toggleterm").setup({})
	end,
}

return M
