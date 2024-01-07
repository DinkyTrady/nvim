-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt --make vim options eazier with variable

local settings = {
  --settingup options
  encoding = "UTF-8",
  numberwidth = 2,
  number = true,
  tabstop = 2,
  softtabstop = 2,
  smartindent = true,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  swapfile = false,
  termguicolors = true,
  clipboard = "unnamedplus",
  mouse = "a",
  showmode = false,
  laststatus = 3,
  showtabline = 0, --Disable tabline
  timeoutlen = 800,
  updatetime = 300,
  ruler = false,
  pumheight = 15,
  scrolloff = 5,
  sidescrolloff = 8,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  undofile = true,
  undodir = vim.fn.stdpath("cache") .. "/undofile",
  writebackup = false,
  -- wrap = true,
  lazyredraw = true,
}
o.shortmess:append("sI")
o.whichwrap:append("<,>,[,],h,l")
o.fillchars = { eob = " " }
o.listchars:append("eol:↴")
o.completeopt = { "menuone", "noselect" }

for name, value in pairs(settings) do
  o[name] = value
end
