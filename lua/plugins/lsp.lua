return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        toml = { 'taplo' },
        typescript = { 'eslint_d' },
        vue = { 'eslint_d' },
      },
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
    },
    init = function()
      vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        sync_install = false,
        ensure_installed = {
          'c',
          'lua',
          'rust',
          'vue',
          'javascript',
          'html',
          'typescript',
          'css',
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconf = require('lspconfig')

      lspconf.clangd.setup({})
      lspconf.eslint.setup({})

      lspconf.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      lspconf.volar.setup({
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      })
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        local configs = require('mason-lspconfig')
        configs.setup({
          ensure_installed = {
            'eslint_d',
            'lua_ls',
            'clangd',
            'html',
            'unocss',
            'tsserver',
            'volar',
          },
        })
      end,
      dependencies = {
        'williamboman/mason.nvim',
        config = function()
          local configs = require('mason')
          configs.setup({
            ui = {
              icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗',
              },
            },
          })
        end,
      },
    },
  },
}
