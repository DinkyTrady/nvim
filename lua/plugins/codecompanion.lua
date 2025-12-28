return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanionChat', 'CodeCompanionActions', 'CodeCompanion', 'CodeCompanionCmd' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
  },
  opts = {
    strategies = {
      chat = {
        opts = {
          completion_provider = 'blink',
        },
        adapter = 'copilot',
      },
      inline = {
        adapter = 'ollama',
      },
    },
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'ollama',
          schema = {
            model = {
              --- change this one to desired llm
              default = 'deepseek-r1:latest',
            },
          },
        })
      end,
      adapters = {
        gemini = {},
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'claude-3.7-sonnet',
              },
            },
          })
        end,
      },
    },
    prompt_library = {
      ['Typescript Developer'] = {
        opts = {
          index = 1,
          ignore_sytem_prompt = true,
        },
        strategy = 'chat',
        prompts = {
          {
            role = 'system',
            content = [[
                You are expert senior fullstack typescript developer that uses bunjs for the runtime, postgresql, Honojs for the server, drizzle for the orm (use bun-sql), and uses zod for validation.
                you always explaining like a teacher that teach their students who doesn't know anything about programming.

                you always use the best practice to give code example of user prompt.
              ]],
          },
          {
            role = 'user',
            content = '',
          },
        },
      },
    },
  },
}
