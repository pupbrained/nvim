return {
	{
		'goolord/alpha-nvim',
		event = 'VimEnter',
		enabled = true,
		init = false,
		opts = function()
			local dashboard = require('alpha.themes.dashboard')

			dashboard.section.header.val = {
				'                                   ',
				'                                   ',
				'                                   ',
				'   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
				'    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
				'          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
				'           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
				'          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
				'   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
				'  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
				' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
				' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
				'      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
				'       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
				'                                   ',
			}

			dashboard.section.buttons.val = {
				dashboard.button('f', ' ' .. ' Recent files', '<CMD>Telescope oldfiles<CR>'),
				dashboard.button('g', ' ' .. ' Find text', '<CMD>Telescope live_grep<CR>'),
				dashboard.button(
					'Z',
					' ' .. ' Open Directories',
					"<CMD>lua require('telescope').extensions.zoxide.list()<CR>"
				),
				dashboard.button('c', ' ' .. ' Config', '<CMD>e ~\\AppData\\Local\\nvim\\init.lua<CR>'),
				dashboard.button('r', ' ' .. ' Restore Session', '<CMD>SessionRestore<CR>'),
				dashboard.button(
					's',
					' ' .. ' Search Sessions',
					'<CMD>lua require("auto-session.session-lens").search_session()<CR>'
				),
				dashboard.button('l', '󰒲 ' .. ' Lazy', '<CMD>Lazy<CR>'),
				dashboard.button('q', ' ' .. ' Quit', '<CMD>qa<CR>'),
			}

			vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#a6e3a1' })
			vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = '#cba6f7' })
			vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = '#f9e2af' })

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = 'AlphaButtons'
				button.opts.hl_shortcut = 'AlphaButtons'
			end
			dashboard.section.header.opts.hl = 'AlphaHeader'
			dashboard.section.buttons.opts.hl = 'AlphaButtons'
			dashboard.section.footer.opts.hl = 'AlphaFooter'
			dashboard.opts.layout[1].val = 3
			return dashboard
		end,

		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == 'lazy' then
				vim.cmd.close()
				vim.api.nvim_create_autocmd('User', {
					once = true,
					pattern = 'AlphaReady',
					callback = function()
						require('lazy').show()
					end,
				})
			end

			require('alpha').setup(dashboard.opts)

			vim.api.nvim_create_autocmd('User', {
				once = true,
				pattern = 'LazyVimStarted',
				callback = function()
					local stats = require('lazy').stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = '⚡ Neovim loaded '
							.. stats.loaded
							.. '/'
							.. stats.count
							.. ' plugins in '
							.. ms
							.. 'ms'
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
