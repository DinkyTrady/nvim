return {
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    event = "LazyFile",
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      _G.Winbar = {}

      local fn = vim.fn
      vim.api.nvim_set_hl(0, "edited", { fg = "#9ece6a" })

      local sep = function()
        ---@diagnostic disable-next-line: deprecated
        if require("nvim-navic").get_location() ~= "" then
          return "%#NavicSeparator#" .. " > " .. "%*"
        end

        return ""
      end

      local fileName = function()
        if vim.bo.filetype ~= "alpha" then
          return "%#NavicText#" .. fn.expand("%:t")
        end

        return ""
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

      vim.opt.winbar = "%{%v:lua.Winbar.setup()%}"

      return {
        click = true,
        highlight = true,
        depth_limit = 5,
        icons = require("lazyvim.config").icons.kinds,
        lazy_update_context = true,
      }
    end,
  },
}
