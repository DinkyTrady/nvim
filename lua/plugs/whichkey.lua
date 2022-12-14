local status, wk = pcall(require, "which-key")
if not status then
  return
end

local setup = {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = true,
      z = true, 
      g = true, 
    },
  },
  key_labels = {
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  ignore_missing = true,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "j" },
    v = { "j", "j" },
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

local mappings = {
  ["e"] = { '<cmd>NvimTreeToggle<cr>', 'Files Explorer' },
  ["s"] = { '<cmd>so<cr>', 'Reload File' },
  w = {
    name = 'Save',
    w = { ':w<cr>', 'Save File' },
    a = { ':wall<cr>', 'Save All Files' },
    q = { ':wq<cr>', 'Save & Quit' },
  },
  q = {
    name = 'Quits',
    q = {':q<cr>', 'Quit File'},
    a = {':qall<cr>', 'Quit All Files'},
    f = {':q!<cr>', 'Force Quit'},
  },
  f = {
    name = 'Telescope',
    t = {':Telescope<cr>', 'Open Telescope'},
    f = {'<cmd>Telescope find_files layout_strategy=vertical<cr>', 'Find Fles'},
    o = {':Telescope oldfiles layout_strategy=vertical<cr>', 'Recent Files'},
    b = {'<cmd>Telescope buffers<cr>', 'Choose Buffers'},
    c = {':Telescope colorscheme<cr>', 'Choose Colorscheme'}
  },
  p = {
    name = 'Packer',
    s = {':PackerStatus<cr>', 'Packer Status'},
    i = {':PackerInstall<cr>', 'Packer Installing Plugins'},
    c = {':PackerCompile<cr>', 'Packer Compile'},
    r = {':PackerClean<cr>', 'Clean Plugins'},
    u = {':PackerSync<cr>', 'Packer Sync'},
  },
  m = {
    name = 'LSP',
    m = {':Mason<cr>', 'Open Mason'},
    i = {':LspInfo<cr>', 'LSP Info'},
    s = {':LspStart<cr>', 'Start LSP'},
    o = {':LspStop<cr>', 'Stop LSP'},
    r = {':LspRestart<cr>', 'Restar LSP'}
  }
}

wk.setup(setup)
wk.register(mappings, opts)
