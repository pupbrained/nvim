return {
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      local surround_config = require('nvim-surround.config')

      require('nvim-surround').setup({
        surrounds = {
          ['('] = {
            add = { '(', ')' },
            find = function()
              return surround_config.get_selection({ motion = '2i(' })
            end,
            delete = '^(. ?)().-( ?.)()$',
          },
          ['{'] = {
            add = { '{', '}' },
            find = function()
              return surround_config.get_selection({ motion = '2i{' })
            end,
            delete = '^(. ?)().-( ?.)()$',
          },
          ['<'] = {
            add = { '<', '>' },
            find = function()
              return surround_config.get_selection({ motion = '2i<' })
            end,
            delete = '^(. ?)().-( ?.)()$',
          },
          ['['] = {
            add = { '[', ']' },
            find = function()
              return surround_config.get_selection({ motion = '2i[' })
            end,
            delete = '^(. ?)().-( ?.)()$',
          },
          ["'"] = {
            add = { "'", "'" },
            find = function()
              return surround_config.get_selection({ motion = "2i'" })
            end,
            delete = '^(.)().-(.)()$',
          },
          ['"'] = {
            add = { '"', '"' },
            find = function()
              return surround_config.get_selection({ motion = '2i"' })
            end,
            delete = '^(.)().-(.)()$',
          },
          ['`'] = {
            add = { '`', '`' },
            find = function()
              return surround_config.get_selection({ motion = '2i`' })
            end,
            delete = '^(.)().-(.)()$',
          },
        },
      })
    end,
  },
}
