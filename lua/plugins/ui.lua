return {
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    name = 'incline',
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
    config = function()
      local helpers = require('incline.helpers')
      local navic = require('nvim-navic')
      local devicons = require('nvim-web-devicons')

      require('incline').setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local res = {
            { '', guibg = '#1e1e2e', guifg = ft_color },
            ft_icon and { ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            guifg = '#cdd6f4',
            guibg = '#181825',
          }
          if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              table.insert(res, {
                { ' > ', group = 'NavicSeparator' },
                { item.icon, group = 'NavicIcons' .. item.type },
                { item.name, group = 'NavicText' },
              })
            end
          end
          table.insert(res, {
            { '', guibg = '#1e1e2e', guifg = '#181825' },
          })
          return res
        end,
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      mason = true,
      modes = true,
    },
    config = function()
      vim.cmd('colorscheme catppuccin')
    end,
  },
  {
    'mvllow/modes.nvim',
    config = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_c = { '%=', 'buffers' },
      },
      options = {
        component_separators = {
          left = '',
          right = '',
        },
        section_separators = {
          left = '',
          right = '',
        },
        theme = 'catppuccin',
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = { hover = { enabled = false } },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = true,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      signcolumn = false,
      numhl = false,
    },
  },
}
