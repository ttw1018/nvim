local custom_config = require("custom.plugins.configs")

return {

	["NvChad/nvterm"] = {
		override_options = custom_config.nvterm,
	},

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = custom_config.treesitter,
	},

	["hrsh7th/nvim-cmp"] = {
		override_options = custom_config.cmp,
	},

	["NvChad/ui"] = {
		override_options = custom_config.ui,
	},

	["nvim-telescope/telescope.nvim"] = {
		override_options = custom_config.telescope,
	},

	["numToStr/Navigator.nvim"] = {
		config = function()
			require("Navigator").setup()
		end,
	},

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["ekickx/clipboard-image.nvim"] = {
		config = function()
      require("clipboard-image").setup({
        markdown = {
          img_dir = {"%:p:h", "img"},
          img_dir_txt = "file:./img",
        }
			})
		end,
		after = "markdown-preview.nvim",
		ft = { "md", "markdown" },
	},

	["jakewvincent/mkdnflow.nvim"] = {
		after = "clipboard-image.nvim",
		config = function()
			require("mkdnflow").setup({
				perspective = {
					priority = "current",
					fallback = "first",
					root_tell = nil,
					nvim_wd_heel = false,
				},
				tables = {
					auto_extend_rows = true,
					auto_extend_cols = true,
				},
				links = {
					transform_explicit = function(text)
						text = text:gsub(" ", "-")
						text = text:lower()
						-- text = "./md/"..text
						return text
					end,
					transform_implicit = false,
				},
				mappings = {
					MkdnYankAnchorLink = false,
					MkdnYankFileAnchorLink = false,
					MkdnGoBack = false,
					MkdnGoForward = false,
					MkdnFoldSection = false,
					MkdnUnfoldSection = false,
					MkdnNextLink = false,
					MkdnPrevLink = false,
					MkdnTableNextCell = false,
					MkdnTablePrevCell = false,
				},
			})
		end,
		ft = { "md", "markdown" },
	},

	["ttw1018/markdown-preview.nvim"] = {
		ft = { "md", "markdown", "tex", "latex" },
	},

	-- ["ethanholz/nvim-lastplace"] = {
	-- 	config = function()
	-- 		require("nvim-lastplace").setup()
	-- 	end,
	-- },

	["folke/todo-comments.nvim"] = {
		after = "cmp-buffer",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	["simrat39/symbols-outline.nvim"] = {
		config = function()
			require("symbols-outline").setup()
		end,
		after = "nvim-lspconfig",
	},

	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	["windwp/nvim-ts-autotag"] = {
		after = "nvim-treesitter",
	},

  ["karb94/neoscroll.nvim"] = {
    config = function ()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb', 'j', 'k'},
      })
    end
  }

	-- ["olimorris/persisted.nvim"] = {
	-- 	config = function()
	-- 		require("persisted").setup({
	-- 			autoload = true,
	-- 			autosave = true,
	-- 		})
	-- 	end,
	-- },
  -- [ "folke/trouble.nvim"] = {
  --   requires = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup {
  --     }
  --   end
  -- }

  -- ["nvim-telescope/telescope-fzf-native.nvim"] = {
  --   run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  -- }
}
