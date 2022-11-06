local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not treesitter_ok then
  return
end

local tsautotag_ok, tsautotag = pcall(require, 'nvim-ts-autotag')
if not tsautotag_ok then
  return 
end

local context_ok, context = pcall(require, 'treesitter-context')
if not context_ok then
  return 
end

treesitter.setup{
  ensure_installed = { 'lua', 'javascript', 'html', 'css' },
  sync_install = false,
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  }
}

tsautotag.setup()

context.setup{}
