local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
  print "Cloning packer .."
  fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

  -- install plugins + compile their configs
  vim.cmd "packadd packer.nvim"
  local r = require
  r('Plugs.plugins')
  r('Plugs.autopairs')
  r('Plugs.cmp')
  r('Plugs.lsp')
  r('Plugs.tokyonight')
  r('Plugs.bufferlines')
  r('Plugs.comment')
  r('Plugs.blankline')
  r('Plugs.lualine')
  r('Plugs.mason')
  r('Plugs.nvim-tree')
  r('Plugs.treesitter')
  vim.cmd "PackerSync"

  -- install binaries from mason.nvim & tsparsers
  vim.api.nvim_create_autocmd("User", {
    pattern = "PackerComplete",
    callback = function()
      vim.cmd "bw | silent! MasonInstallAll" -- close packer window
      require("packer").loader "nvim-treesitter"
    end,
  })
end
r('Plugs.key')
