return {
	{
		'SmiteshP/nvim-navic',
		dependencies = { 'neovim/nvim-lspconfig' },
		config = true,
	},
	{
		'rcarriga/nvim-dap-ui',
		dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
		config = true,
	},
	{
		'mfussenegger/nvim-dap',
		config = function()
			local dap = require('dap')

			dap.adapters.lldb = {
				type = 'executable',
				command = 'C:\\msys64\\clang64\\bin\\lldb-dap.exe', -- adjust as needed, must be absolute path
				name = 'lldb',
			}

			dap.configurations.cpp = {
				{
					name = 'Launch',
					type = 'lldb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.rust = {
				{
					name = 'Launch',
					type = 'lldb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},

					initCommands = function()
						local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

						local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
						local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

						local commands = {}
						local file = io.open(commands_file, 'r')
						if file then
							for line in file:lines() do
								table.insert(commands, line)
							end
							file:close()
						end
						table.insert(commands, 1, script_import)

						return commands
					end,
				},
			}
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				globalstatus = true,

				component_separators = {
					left = '',
					right = '',
				},

				section_separators = {
					left = '',
					right = '',
				},
			},
			sections = {
				lualine_a = {
					{
						'mode',

						padding = {
							left = 1,
							right = 2,
						},

						separator = {
							left = '',
						},
					},
				},
				lualine_b = { 'filename', 'branch' },
				lualine_c = {
					'%=',
					{
						'buffers',

						symbols = {
							modified = ' ●', -- Text to show when the buffer is modified
							alternate_file = '​', -- Text to show to identify the alternate file
							directory = '', -- Text to show when the buffer is a directory
						},
					},
				},
				lualine_x = {
					'encoding',
					{
						'fileformat',
						padding = {
							left = 1,
							right = 2,
						},
					},
				},
				lualine_y = { 'filetype', 'progress' },
				lualine_z = {
					{
						'location',
						padding = {
							left = 2,
							right = 1,
						},
						separator = {
							right = '',
						},
					},
				},
			},
		},
	},
	{
		'folke/trouble.nvim',
		cmd = 'Trouble',
		config = true,
		keys = {
			{
				'<leader>xx',
				'<cmd>Trouble diagnostics toggle<cr>',
				desc = 'Diagnostics (Trouble)',
			},
			{
				'<leader>xX',
				'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
				desc = 'Buffer Diagnostics (Trouble)',
			},
			{
				'<leader>cs',
				'<cmd>Trouble symbols toggle focus=false<cr>',
				desc = 'Symbols (Trouble)',
			},
			{
				'<leader>cl',
				'<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
				desc = 'LSP Definitions / references / ... (Trouble)',
			},
			{
				'<leader>xL',
				'<cmd>Trouble loclist toggle<cr>',
				desc = 'Location List (Trouble)',
			},
			{
				'<leader>xQ',
				'<cmd>Trouble qflist toggle<cr>',
				desc = 'Quickfix List (Trouble)',
			},
		},
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {
			disable_filetype = { 'TelescopePrompt', 'guihua', 'guihua_rust', 'clap_input' },
		},
	},
	{
		'ray-x/navigator.lua',
		dependencies = { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
		config = function()
			require('navigator').setup({
				keymaps = {
					{
						key = '<Leader>r',
						func = require('navigator.rename').rename,
						desc = 'rename',
					},
				},
			})
		end,
	},
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
				desc = 'Code action',
			},
		},
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		lazy = false,   -- This plugin is already lazy
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
			local navic = require('nvim-navic')

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end
			end

			require('lspconfig.ui.windows').default_options.border = 'rounded'

			lspconf.clangd.setup({
				on_attach = on_attach,
				cmd = {
					'C:/msys64/clang64/bin/clangd.exe',
					'--query-driver="C:/msys64/clang64/bin/clang-*"',
					'--enable-config',
					'--background-index',
					'--clang-tidy',
					'--completion-style=detailed',
					'--function-arg-placeholders',
					'--fallback-style=llvm',
					'--log=verbose',
					'--pretty',
				},
			})

			lspconf.eslint.setup({
				on_attach = on_attach,
			})

			lspconf.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
					},
				},
			})

			lspconf.volar.setup({
				on_attach = on_attach,
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
