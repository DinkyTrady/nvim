return {
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    require("lazyvim.util").lsp.on_attach(function(client, buffer)
      if client.supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = {},
  config = function()
    vim.api.nvim_set_hl(0, "NavicText", { link = "@variable" })

    require("nvim-navic").setup({
      click = true,
      highlight = true,
      depth_limit = 5,
      icons = require("lazyvim.config").icons.kinds,
      lazy_update_context = true,
    })

    _G.Winbar = {}

    local fn = vim.fn
    vim.api.nvim_set_hl(0, "edited", { fg = "#9ece6a" })

    local sep = function()
      ---@diagnostic disable-next-line: deprecated
      if next(vim.lsp.buf_get_clients(0)) ~= nil and require("nvim-navic").get_location() ~= "" then
        return "%#NavicSeparator#" .. " > " .. "%*"
      end
      return ""
    end

    local fileName = function()
      if vim.bo.filetype == "alpha" then
        return ""
      else
        return "%#NavicText#" .. fn.expand("%:t")
      end
    end

    local function modified()
      if vim.bo.modified then
        return "%#edited#" .. " ●" .. "%*"
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return " "
      end
      return ""
    end

    _G.Winbar.setup = function()
      return table.concat({
        " ",
        fileName(),
        modified(),
        sep(),
        require("nvim-navic").get_location(),
      })
    end

    vim.opt.winbar = "%!v:lua.Winbar.setup()"
  end,
}
