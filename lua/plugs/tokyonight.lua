local status, _ = pcall(vim.cmd, 'colorscheme tokyonight')
if not status then
  vim.cmd[[colorscheme slate]]
end
if status then
  vim.cmd[[colorscheme tokyonight]]
end

local status_ok, tokyonight = pcall(require, 'tokyonight')
if not status_ok then
  return
end
tokyonight.setup({
  style = "storm",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true, italic = true },
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  hide_inactive_statusline = false,
  lualine_bold = true,
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
})
