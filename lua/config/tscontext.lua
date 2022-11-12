local status, context = pcall(reqyire, 'treesitter-context')
if not status then
  return
end

context.setup{}