local o = vim.opt

local settings = {
  --	showtabline = 0, -- gonna hide tabline or buffer
  -- clipboard = 'unnamedplus',
  -- showmode = false,
  -- statuscolumn = ' %s%l%= %C ',
  autoindent = true,
  cmdheight = 1,
  completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' },
  expandtab = true,
  hlsearch = true,
  ignorecase = true,
  laststatus = 3,
  lazyredraw = true,
  mouse = 'a',
  number = true,
  numberwidth = 1,
  pumheight = 15,
  relativenumber = true,
  scrolloff = 5,
  shiftwidth = 2,
  sidescrolloff = 8,
  signcolumn = 'yes',
  smartcase = true,
  smartindent = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 600,
  undodir = vim.fn.stdpath 'cache' .. '/undofile',
  undofile = true,
  updatetime = 50,
  winborder = 'rounded',
  wrap = false,
  exrc = true,
  secure = true,
}

o.shortmess:append 'sI'
o.whichwrap:append '<,>,[,],h,l'

for name, value in pairs(settings) do
  o[name] = value
end
