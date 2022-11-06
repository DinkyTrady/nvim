local status, onedark = pcall(require, 'onedark')
if not status then
  return
end

onedark.setup {
  style = 'cool',
  lualine = {
    transparent = true
  },
  highlights = {
    rainbowcol1 = {fg='#a5b0c5'},
    NvimTreeGitDirty = {fg='#5ab0f6'},
  }
}
onedark.load()
