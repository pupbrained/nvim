return {
  {
    'LhKipp/nvim-nu',
    dependencies = { 'nvimtools/none-ls.nvim' },
    init = function()
      require('nu').setup()
    end,
  },
  {
    'aznhe21/actions-preview.nvim',
    opts = {
      telescope = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = 'top',
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
    keys = {
      {
        '<leader>a',
        '<CMD>lua require("actions-preview").code_actions()<CR>',
        mode = 'n',
        desc = 'Toggle NvimTree',
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.o.shiftwidth = 2
    end,
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
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '<leader>d',
        '<CMD>lua vim.diagnostic.open_float()<CR>',
        mode = 'n',
        desc = 'Show Line Diagnostics',
      },
      {
        '<leader>n',
        '<CMD>lua vim.diagnostic.goto_next()<CR>',
        mode = 'n',
        desc = 'Next Diagnostic',
      },
      {
        '<leader>N',
        '<CMD>lua vim.diagnostic.goto_prev()<CR>',
        mode = 'n',
        desc = 'Previous Diagnostic',
      },
      {
        '<F2>',
        '<CMD> lua vim.lsp.buf.rename()<CR>',
        mode = 'n',
        desc = 'Rename',
      },
    },
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
        filetypes = {
          'typescript',
          'javascript',
          'javascriptreact',
          'typescriptreact',
          'vue',
          'json',
        },
      })
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        local configs = require('mason-lspconfig')
        configs.setup({
          ensure_installed = {
            'eslint',
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
