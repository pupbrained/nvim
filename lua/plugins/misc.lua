return {
	{
		'LintaoAmons/cd-project.nvim',
		opts = {
			projects_picker = 'telescope',
		},
		keys = {
			{
				'<leader>p',
				'<CMD>CdProject<CR>',
				mode = 'n',
				desc = 'Select Project',
			},
		},
	},
	{ 'romainl/vim-cool' },
	{
		'j-morano/buffer_manager.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
		keys = {
			{
				'<leader>b',
				'<CMD>lua require("buffer_manager.ui").toggle_quick_menu()<CR>',
				mode = 'n',
				desc = 'Buffer Manager',
			},
		},
	},
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
		'rmagatti/auto-session',
		opts = {
			log_level = 'error',
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { '~/', '~/Downloads' },
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
				'<leader>e',
				'<CMD>NvimTreeToggle<CR>',
				mode = 'n',
				desc = 'Toggle NvimTree',
			},
		},
		opts = { sync_root_with_cwd = true },
	},
}
