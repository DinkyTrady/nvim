local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end
telescope.setup({
  defaults = {
    prompt_prefix = "  ",
    sorting_strategy = 'ascending',
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
        },
        ["n"] = {
          ["-"] = telescope.extensions.file_browser.actions.goto_parent_dir,
          ["n"] = telescope.extensions.file_browser.actions.create,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")
