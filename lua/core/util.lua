local M = {}

local cached_root = nil
local last_cwd = nil

function M.get_project_root()
  local cur_cwd = vim.uv.cwd()

  if last_cwd ~= cur_cwd then
    cached_root = nil
    last_cwd = cur_cwd
  end

  if cached_root then
    return cached_root
  end

  -- get root projects with lsp
  local cur_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = cur_buf }
  for _, client in ipairs(clients) do
    if client.root_dir and client.root_dir ~= '' then
      cached_root = client.root_dir
      return cached_root
    end
  end

  -- fallback root projects use git
  local git_root = vim.fn.trim(vim.fn.system 'git rev-parse --show-toplevel')
  if vim.v.shell_error == 0 and git_root ~= '' then
    cached_root = git_root
    return cached_root
  end

  cached_root = cur_cwd
  return cached_root
end

M.diagnostics = {
  signs = {
    Error = 'E',
    Warn = 'W',
    Hint = 'H',
    Info = 'I',
  },
}

M.filetypes = {
  ignore = {
    commit = true,
    codecompanion = true,
    help = true,
    xxd = true,
    oil = true,
    qf = true,
    lazy = true,
    mason = true,
  },
  ---@param buf? integer
  ---@return boolean
  should_ignore = function(buf)
    buf = buf or 0
    if not vim.api.nvim_buf_is_valid(buf) then
      return false
    end
    return M.filetypes.ignore[vim.bo[buf].filetype] == true
  end,
}

return M
