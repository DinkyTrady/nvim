local o = vim.opt

local settings = {
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	smartindent = true,
	numberwidth = 1,
	number = true,
	relativenumber = true,
	lazyredraw = true,
	hlsearch = true,
	autoindent = true,
	smartcase = true,
	mouse = "a",
	ignorecase = true,
	termguicolors = true,
	--	showtabline = 0, -- gonna hide tabline or buffer
	timeoutlen = 600,
	updatetime = 50,
	pumheight = 15,
	undofile = true,
	undodir = vim.fn.stdpath("cache") .. "undofile",
	completeopt = { "menu", "menuone", "noselect", "noinsert" },
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
	wrap = false,
	clipboard = "unnamedplus",
	showmode = false,
	swapfile = false,
}

o.whichwrap:append("<,>,[,],h,l")
o.shortmess:append("sI")

for name, value in pairs(settings) do
	o[name] = value
end
