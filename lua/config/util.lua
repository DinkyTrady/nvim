local M = {}

function M.get_project_root()
  -- get root projects with lsp
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients > 0 then
    return clients[1].root_dir
  end

  -- fallback root projects use git
  local git_root = vim.fn.trim(vim.fn.system 'git rev-parse --show-toplevel')
  if vim.v.shell_error == 0 then
    return git_root
  end

  return vim.fn.getcwd()
end

return M
