local M = {}

M.config = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	config = function()
		require("configs.telescope").setup()
	end,
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-lua/plenary.nvim",
		{
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({
					detection_methods = { "pattern" },
					silent_chdir = true,
				})
			end,
		},
	},
}

function M.setup()
	local telescope_ok, telescope = pcall(require, "telescope")
	if not telescope_ok then
		return
	end

	local options = {
		defaults = {
			prompt_prefix = "   ",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				height = 0.80,
			},
			mappings = {
				n = { ["q"] = require("telescope.actions").close },
			},
		},
		extensions = {
			file_browser = {
				hidden = true,
				mappings = {
					["i"] = {
						["/"] = telescope.extensions.file_browser.actions.create,
						["<C-r>"] = telescope.extensions.file_browser.actions.remove,
					},
					["n"] = {
						["-"] = telescope.extensions.file_browser.actions.goto_parent_dir,
						["n"] = telescope.extensions.file_browser.actions.create,
					},
				},
			},
			projects = {
				projects = {},
			},
		},
	}

	telescope.setup(options)
	telescope.load_extension("file_browser")
	telescope.load_extension("projects")
end

return M
