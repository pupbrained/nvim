require('config.lazy')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_floating_shadow = false

vim.o.autoindent = true
vim.o.cindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.number = true
vim.o.relativenumber = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.undofile = true

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('v', 's', "<Esc><CMD>'<,'>!sort<CR>")
vim.keymap.set('n', 'H', '<CMD>bprev<CR>')
vim.keymap.set('n', 'L', '<CMD>bnext<CR>')
