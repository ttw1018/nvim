local use = require("packer").use
return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- use 'christoomey/vim-tmux-navigator'

	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({})
		end,
	})

	use({
		"NTBBloodbath/doom-one.nvim",
		config = function()
			require("doom-one").setup({})
		end,
	})

	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	use("windwp/nvim-autopairs")

	use("windwp/nvim-ts-autotag")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("ethanholz/nvim-lastplace")

	use({
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup({
				-- overwrite default configuration
				-- here, e.g. to enable default bindings
				copy_sync = {
					-- enables copy sync and overwrites all register actions to
					-- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
					enable = true,
				},
				navigation = {
					-- enables default keybindings (C-hjkl) for normal mode
					enable_default_keybindings = true,
				},
				resize = {
					-- enables default keybindings (A-hjkl) for normal mode
					enable_default_keybindings = true,
				},
			})
		end,
	})

	use({
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				filetype = {
					lua = {
						function()
							return {
								exe = "stylua",
								args = { "-" },
								stdin = true,
							}
						end,
					},

					cpp = {
						-- clang-format
						function()
							return {
								exe = "clang-format",
								args = { "-" },
								stdin = true,
								cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
							}
						end,
					},

					python = {
						-- Configuration for psf/black
						function()
							return {
								exe = "black", -- this should be available on your $PATH
								args = { "-" },
								stdin = true,
							}
						end,
					},
				},
			})
		end,
	})
end)
