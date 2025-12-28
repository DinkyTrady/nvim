local util = require 'core.util'

return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  -- stylua: ignore
  keys = {
    { '<leader>x',       function() Snacks.bufdelete() end,                                                                   'Remove buffer' },
    { ';w',              function() Snacks.picker.grep() end,                                                                 'Find Words (cwd)' },
    { ';f',              function() Snacks.picker.files { hidden = true } end,                                                'Find Files' },
    { ';F',              function() Snacks.picker.files { hidden = true, ignored = true, cwd = util.get_project_root() } end, 'Find Files (cwd)' },
    { ';r',              function() Snacks.picker.recent { cwd = util.get_project_root() } end,                               'Find Recent Files' },
    { ';b',              function() Snacks.picker.buffers { current = false } end,                                            'Find Buffers' },
    { ';h',              function() Snacks.picker.help() end,                                                                 'Help pages' },
    { ';m',              function() Snacks.picker.keymaps() end,                                                              'Find Keymaps' },
    { '<localleader>z',  function() Snacks.picker.zoxide() end,                                                               'Change directory with zoxide' },
    { ';c',              function() Snacks.picker.files { hidden = true, ignored = true, cwd = vim.fn.stdpath 'config' } end, 'Opening config' },
    { ';C',              function() Snacks.picker.files { hidden = true, ignored = true, cwd = '~/personal/dotsfiles' } end,  'Opening config' },
    { '<localleader>gg', function() Snacks.lazygit() end,                                                                     'Open LazyGit' },
    { '<C-/>',           function() Snacks.terminal() end,                                                                    'Open Terminal' },
  },
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'OilActionsPost',
      callback = function(args)
        if args.data.actions.type == 'move' then
          Snacks.rename.on_rename_file(args.data.actions.src_url, args.data.actions.dest_url)
        end
      end,
    })

    --- source code from https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
    vim.api.nvim_create_autocmd('LspProgress', {
      callback = function(args)
        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(vim.lsp.status(), 'info', {
          id = 'lsp_progress',
          title = 'LSP Progress',
          opts = function(notif)
            notif.icon = args.data.params.value.kind == 'end' and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })

    require('snacks').setup {
      -- indent = {},
      bigfile = {},
      picker = {},
      input = {},
      statuscolumn = {},
      dashboard = {
        formats = {
          key = function(item)
            return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
          end,
        },
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files (cwd) ', file = vim.fn.fnamemodify('.', ':~'), padding = 1 },
          { section = 'recent_files', cwd = true, limit = 5, padding = 1, indent = 2 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      image = {},
      notifier = {},
      notify = {},
      quickfile = {},
      terminal = {},
      -- words = {},
    }
  end,
}
