return {
  { 'romainl/vim-cool' },
  {
    'willothy/savior.nvim',
    dependencies = { 'j-hui/fidget.nvim', opts = {} },
    event = { 'InsertEnter', 'TextChanged' },
    config = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'jvgrootveld/telescope-zoxide',
    },
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },
  { 'folke/which-key.nvim' },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'float',
      open_mapping = [[<c-t>]],
      float_opts = { border = 'curved' },
      shell = 'nu.exe',
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>e',
        '<CMD>NvimTreeToggle<CR>',
        mode = 'n',
        desc = 'Toggle NvimTree',
      },
    },
    config = function()
      require('nvim-tree').setup({})
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
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      vim.cmd('colorscheme catppuccin')
    end,
  },
}
