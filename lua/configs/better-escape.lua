local setup = {
	config = {
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			local status, bs = pcall(require, "better_escape")
			if not status then
				return
			end

			bs.setup({ clear_empty_lines = true, mapping = { "jk", "jj", "kj", "kk" } })
		end,
	},
}

return setup
