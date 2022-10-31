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
    offsets = {
      {
        filetype = "NvimTree",
        text = "  File Explorer  ",
        highlight = "Directory",
        padding = 1,
      },
    },
  },
})
