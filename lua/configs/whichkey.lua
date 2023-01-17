local status, wk = pcall(require, "which-key")
if not status then
  return
end

local setup = {
  plugins = {
    spelling = {
      enabled = true,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
    },
  },
  window = {
    border = "rounded",
  },
  popup_mappings = {
    scroll_down = "<C-j>",
    scroll_up = "<C-k>",
  },
  triggers_blacklist = {
    i = { "j", "j" },
    n = { "z", "g", "d" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = require("core.mappings").whichkey
wk.setup(setup)
wk.register(mappings, opts)
