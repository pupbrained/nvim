return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 1000,
		opts = {
			colorful_winsep = {
				enabled = true,
				color = 'green',
			},
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
			options = { theme = 'catppuccin' },
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
	{
		'nvim-zh/colorful-winsep.nvim',
		config = true,
		event = { 'WinNew' },
	},
}
