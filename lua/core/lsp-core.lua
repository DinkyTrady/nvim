local M = {}

---@param client vim.lsp.Client
M.on_attach = function(client, bufnr)
  local vl, va = vim.lsp, vim.api
  local lsp_method = vl.protocol.Methods

  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    desc = desc or ''
    vim.keymap.set(mode, keys, func, { desc = 'LSP: ' .. desc, buffer = bufnr })
  end

  ---@param method vim.lsp.protocol.Method
  local csm = function(method)
    return client:supports_method(method, bufnr)
  end

  map('grn', vl.buf.rename, '[R]ename')
  map('gra', vl.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map('grr', function()
    local win = va.nvim_get_current_win()

    vl.buf.references(nil, {
      on_list = function(options)
        if va.nvim_win_is_valid(win) then
          vim.fn.setqflist({}, ' ', options)
          vim.cmd.copen()
          va.nvim_set_current_win(win)
        end
      end,
    })
  end, '[G]oto [R]efrences')
  map('gri', vl.buf.implementation, '[G]oto [I]mplementation')
  map('grd', vl.buf.definition, '[G]oto [D]efinition')
  map('grt', vl.buf.type_definition, '[G]oto [T]ype Definition')
  map('gO', vl.buf.document_symbol, '[G]oto [D]ocument Symbol')
  map('<C-s>', vl.buf.signature_help, '[O]pen [S]ymbol', { 'i' })
  map('K', vl.buf.hover, '[O]pen [H]over')
  map('grD', vl.buf.declaration, '[G]oto [D]eclaration')

  if csm(lsp_method.textDocument_documentHighlight) then
    local lsp_highlight = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = lsp_highlight,
      buffer = bufnr,
      callback = vl.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = lsp_highlight,
      buffer = bufnr,
      callback = vl.buf.clear_references,
    })
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('lsp-highlight-clear', { clear = true }),
      callback = function(args)
        vl.buf.clear_references()
        va.nvim_clear_autocmds { group = lsp_highlight, buffer = args.buf }
      end,
    })
  end

  if csm(lsp_method.textDocument_inlayHint) then
    vl.inlay_hint.enable(true, { bufnr = bufnr })
    map('grh', function()
      vl.inlay_hint.enable(not vl.inlay_hint.is_enabled { bufnr = bufnr })
    end, '[T]oggle [I]nlay [H]int')
  end

  if csm 'textDocument/foldingRange' then
    vim.wo[0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  else
    vim.wo[0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}

-- M.capabilities = vim.tbl_deep_extend('force', capabilities, require('blink-cmp').get_lsp_capabilities({}, true))
M.capabilities = require('blink-cmp').get_lsp_capabilities()

return M
