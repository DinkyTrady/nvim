local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return 
end

bufferline.setup({
  options = {
    indicator = {
      icon = '▎ ',
      style = 'icon',
    },
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or ""
      return icon .. count
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "  File Explorer  ",
        highlight = "Directory",
        separator = true,
        padding = 1,
      },
    },
  },
})
