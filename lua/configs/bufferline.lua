local M = {}

M.config = {
  "akinsho/bufferline.nvim",
  version = "v3.*",
  event = "BufAdd",
  config = function()
    require("configs.bufferline").setup()
  end,
}

function M.setup()
  local bufferline_ok, bufferline = pcall(require, "bufferline")
  if not bufferline_ok then
    return
  end

  bufferline.setup({
    options = {
      numbers = "ordinal",
      offsets = {
        {
          filetype = "neo-tree",
          text = "  File Explorer  ",
          highlight = "NvimTreeBufferLine",
          padding = 0,
        },
        { filetype = "" },
      },
      always_show_bufferline = false,
    },
    highlights = {
      buffer_selected = {
        italic = false,
      },
      numbers_selected = {
        italic = false,
      },
    },
  })
end

return M
