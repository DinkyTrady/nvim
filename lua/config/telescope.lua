local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  return
end
telescope.setup{
  defaults = {
    prompt_prefix = "  ",
    layout_strategy = 'horizontal',
    layout_config = {
      horiozontal = {
        prompt_position = 'top'
      },
      vertical = {
        mirror = false
      }
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
}
