local status, ns = pcall(require, 'neoscroll')
if not status then
  return 
end

ns.setup{
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb', 'Down', 'Up'},
}
