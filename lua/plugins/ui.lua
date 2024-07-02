return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,    -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			colorful_winsep = {
				enabled = true,
				color = 'green',
			},
		},
		config = function()
			vim.cmd('colorscheme catppuccin')
		end,
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
	{
		'nvim-zh/colorful-winsep.nvim',
		config = true,
		event = { 'WinNew' },
	},
}
