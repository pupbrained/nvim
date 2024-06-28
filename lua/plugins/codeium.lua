return {
  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-nvim-lua',
          'onsails/lspkind.nvim',
        },
        config = function()
          local cmp = require('cmp')

          cmp.setup({
            formatting = {
              format = require('lspkind').cmp_format({
                mode = 'symbol',
                maxwidth = 50,
                ellipsis_char = '...',
                symbol_map = { Codeium = '' },
              }),
            },
            sources = {
              { name = 'codeium' },
              { name = 'nvim_lsp' },
              { name = 'buffer' },
              { name = 'path' },
              { name = 'nvim_lua' },
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
          })
        end,
      },
    },
    config = function()
      require('codeium').setup({})
    end,
  },
}
