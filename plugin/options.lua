local vo = vim.opt

-- o.clipboard = 'unnamedplus'
-- o.showmode = false
-- o.showtabline = 0 -- gonna hide tabline or buffer
-- o.statuscolumn = ' %s%l%= %C '
vo.autoindent = true
vo.cmdheight = 1
vo.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vo.expandtab = true
vo.hlsearch = true
vo.ignorecase = true
vo.laststatus = 3
vo.lazyredraw = true
vo.mouse = 'a'
vo.number = true
vo.numberwidth = 1
vo.pumheight = 15
vo.relativenumber = true
vo.scrolloff = 5
vo.shiftwidth = 2
-- vo.shortmess:append 'sI'
vo.sidescrolloff = 8
vo.signcolumn = 'yes'
vo.smartcase = true
vo.smartindent = true
vo.softtabstop = 2
vo.splitbelow = true
vo.splitright = true
vo.swapfile = false
vo.tabstop = 2
vo.termguicolors = true
vo.timeoutlen = 600
vo.undodir = vim.fn.stdpath 'cache' .. '/undofile'
vo.undofile = true
vo.updatetime = 50
vo.whichwrap:append '<,>,[,],h,l'
vo.winborder = 'rounded'
vo.wrap = false
