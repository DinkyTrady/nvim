local M = {}
local lazy_group = vim.api.nvim_create_augroup('LazyLoad', { clear = true })
local loaded_plugins = {}

---@param plugins (string|vim.pack.Spec)[]
function M.lazy_load(plugins)
  vim.pack.add(plugins, {
    load = function(plugin)
      local data = plugin.spec.data or {}

      local function load_conf()
        if data.config then
          data.config(plugin)
        end
      end

      local function load_plugin_and_config()
        if loaded_plugins[plugin.spec.name] then
          return
        end
        vim.cmd.packadd(plugin.spec.name)
        load_conf()
        loaded_plugins[plugin.spec.name] = true
      end

      local lazy = data.lazy == nil and true or data.lazy
      if not lazy then
        load_plugin_and_config()
      end

      if data.event then
        vim.api.nvim_create_autocmd(data.event, {
          group = lazy_group,
          once = true,
          callback = load_plugin_and_config,
        })
      end

      if data.cmd then
        local list_cmd
        if type(data.cmd) =="table" then
          list_cmd = data.cmd
        else
          list_cmd = { data.cmd }
        end
        for _, command in pairs(list_cmd) do
        vim.api.nvim_create_user_command(command, function(cmd_args)
          pcall(vim.api.nvim_del_user_command, command)
          load_plugin_and_config()

          vim.api.nvim_cmd({
            cmd = command,
            args = cmd_args.fargs,
            bang = cmd_args.bang,
            nargs = cmd_args.nargs,
            range = cmd_args.range ~= 0 and { cmd_args.line1, cmd_args.line2 } or nil,
            count = cmd_args.count ~= -1 and cmd_args.count or nil,
          }, {})
        end, { nargs = data.nargs, range = data.range, bang = data.bang, complete = data.complete, count = data.count })
        end
      end

      if data.keys then
        local keymaps = {}
        if type(data.keys[1]) == 'table' then
          keymaps = data.keys
        else
          keymaps = { data.keys }
        end
        for _, keymap_data in ipairs(keymaps) do
          local mode, lhs, cmd, desc = keymap_data[1], keymap_data[2], keymap_data[3], keymap_data[4]
          vim.keymap.set(mode, lhs, function()
            -- vim.keymap.del(mode, lhs)
            load_plugin_and_config()
            if type(cmd) == 'string' then
              vim.cmd(cmd)
            elseif type(cmd) == 'function' then
              cmd()
            end
          end, { desc = desc })
        end
      end
    end,
  })
end

return M
