vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.hls = true
vim.o.autoindent = true
vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.undofile = false

vim.opt.completeopt = "menu,menuone"

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	update_to_buf_dir = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		auto_resize = false,
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

require("doom-one").setup({
	cursor_coloring = false,
	terminal_colors = false,
	italic_comments = false,
	enable_treesitter = true,
	transparent_background = false,
	pumblend = {
		enable = true,
		transparency_amount = 20,
	},
	plugins_integrations = {
		neorg = true,
		barbar = true,
		bufferline = false,
		gitgutter = false,
		gitsigns = true,
		telescope = false,
		neogit = true,
		nvim_tree = true,
		dashboard = true,
		startify = true,
		whichkey = true,
		indent_blankline = true,
		vim_illuminate = true,
		lspsaga = false,
	},
})

require("nvim-treesitter.configs").setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "maintained",

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- List of parsers to ignore installing
	ignore_install = {},

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

require("nvim-autopairs").setup({})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

require("nvim-lastplace").setup({
	lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
	lastplace_open_folds = true,
})

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua,*.py,*.tex,*.json.*.cpp,*.c FormatWrite
augroup END
]],
	true
)
