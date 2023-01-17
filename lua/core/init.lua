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

  vim.api.nvim_command([[packadd packer.nvim]])
  print("Clone Packer and Sync Plugins")
  require("configs.plugins")
  vim.api.nvim_command("PackerSync")
end

require("others.autocmds")

require("others.statusline").setup()
