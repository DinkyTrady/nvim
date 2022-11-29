require("core.options")
require("core.mappings")
require("core.disable")

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  vim.cmd([[packadd packer.nvim]])
  print("Clone Packer and Sync Plugins")
  require("configs.plugins")
  vim.cmd("PackerSync")
end

if vim.bo.filetype == "alpha" then
  vim.opt.statusline = " "
else
  vim.opt.statusline = "%{%v:lua.require'others.statusline'.sep()%}"
    .. "%{%v:lua.require'others.statusline'.mode()%}"
    .. "%{%v:lua.require'others.statusline'.filetype()%}"
    .. "%{%v:lua.require'others.statusline'.git_head()%}"
    .. "%{%v:lua.require'others.statusline'.diagnostics()%}"
    .. "%="
    .. "%{%v:lua.require'others.statusline'.dir()%}"
    .. "%="
    .. " "
    .. "%{%v:lua.require'others.statusline'.git()%}"
    .. "%{%v:lua.require'others.statusline'.cursor_position()%}"
    .. "%{%v:lua.require'others.statusline'.progress()%}"
end
