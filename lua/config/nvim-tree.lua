local tree_ok, tree = pcall(require, "nvim-tree")
if not tree_ok then
	return
end

tree.setup {
	sort_by = "case_sensitive",
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		number = true,
		width = 35,
		adaptive_size = false,
		hide_root_folder = true,
		side = "left",
		relativenumber = false,
	},
	renderer = {
		group_empty = true,
		indent_width = 2,
		indent_markers = {
			enable = true,
		},
		highlight_git = true,
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 50,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
}
