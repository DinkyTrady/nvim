local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end
telescope.setup {
	defaults = {
		prompt_prefix = "  ",
		layout_strategy = "horizontal",
		layout_config = {
			horiozontal = {
				prompt_position = "top",
			},
			vertical = {
				mirror = false,
			},
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
				},
				["n"] = {
					["-"] = telescope.extensions.file_browser.actions.goto_parent_dir,
					["n"] = telescope.extensions.file_browser.actions.create,
				},
			},
		},
	},
}

telescope.load_extension "file_browser"

vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope file_browser<cr>", { noremap = true })
