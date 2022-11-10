local status, tokyonight = pcall(require, 'tokyonight')
if not status then
  return
end

tokyonight.setup({
  style = "storm",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  hide_inactive_statusline = false,
  lualine_bold = true,
  on_colors = function(colors) end,
  on_highlights = function(hl, c)
    hl.NvimTreeFolderIcon = { fg='#639fff' }
    hl.NvimTreeIndentMarker = { fg='#f5f5f5' }
  end,
})
