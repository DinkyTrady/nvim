local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not treesitter_ok then
  return
end

treesitter.setup({
  ensure_installed = { 'lua', 'javascript', 'html', 'css' },
  sync_install = true,
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autotag = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  }
})
