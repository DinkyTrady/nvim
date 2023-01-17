local M = {}

M.node = function()
  if not vim.bo.filetype == "javascript" then
    print("it's not javascript file yet")
  end
  local node = string.format("!node %s", vim.fn.expand("%p:h"))
  return node
end

return M
