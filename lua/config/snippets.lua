local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()

local parse = ls.parser.parse_snippet
local types = require("luasnip.util.types")

ls.config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_base_prio = 300,
  ext_prio_increase = 2,
  ship_env = {
    types = types,
    parse = parse,
  },
})
