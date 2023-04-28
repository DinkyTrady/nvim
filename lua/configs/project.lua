local M = {}

M.config = {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			detection_methods = { "pattern" },
			-- show_hidden = true,
			silent_chdir = true,
		})
	end,
}

return M
