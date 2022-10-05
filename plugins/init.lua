local custom_config = require("custom.plugins.configs")

return {

  -- ["folke/which-key.nvim"] = {
  --   disable = false,
  -- },
  --
  ["NvChad/nvterm"] = {
    override_options = custom_config.nvterm,
  },

  -- ["kyazdani42/nvim-tree.lua"] = {
  --   override_options = custom_config.nvimtree,
  -- },

  -- ["NvChad/extensions"] = {
  --   disable = true,
  -- },

  ["hrsh7th/nvim-cmp"] = {
    override_options = custom_config.cmp
  },

  ["NvChad/ui"] = {
    override_options = custom_config.ui,
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = custom_config.telescope,
  },

  -- ["numToStr/Navigator.nvim"] = {
  --   config = function()
  --     require('Navigator').setup()
  --   end
  -- },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["ekickx/clipboard-image.nvim"] = {
    config = function ()
      require("clipboard-image").setup {
        markdown = {
          img_dir_txt = "file:../img",
        },
      }
    end,
    after="markdown-preview.nvim",
    ft = {'md', 'markdown'},
  },

  ["jakewvincent/mkdnflow.nvim"] = {
    after = "clipboard-image.nvim",
    config = function()
      require('mkdnflow').setup({
        perspective = {
          priority = 'current',
          fallback = 'first',
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
            return(text)
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
        }
      })
    end,
    ft = {'md', 'markdown'}
  },

  ["ttw1018/markdown-preview.nvim"] = {
    ft = {'md', 'markdown', 'tex', 'latex' }
  },
  -- ["f3fora/cmp-spell"] = {
  --   after = "cmp-buffer"
  -- },
  ["hrsh7th/cmp-emoji"] = {
    after = "cmp-buffer"
  },

  ["hrsh7th/cmp-cmdline"] = {
    after = "cmp-buffer"
  },

  ["ethanholz/nvim-lastplace"] = {
    config = function ()
      require("nvim-lastplace").setup()
    end
  },

  ["folke/todo-comments.nvim"] = {
    after = "cmp-buffer",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end
  },

  ["simrat39/symbols-outline.nvim"] = {
    config = function ()
      require("symbols-outline").setup()
    end,
    after = "nvim-lspconfig",
  },

  ["abecodes/tabout.nvim"] = {
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          {open = "'", close = "'"},
          {open = '"', close = '"'},
          {open = '`', close = '`'},
          {open = '(', close = ')'},
          {open = '[', close = ']'},
          {open = '{', close = '}'}
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    wants = {'nvim-treesitter'}, -- or require if not used so far
    after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
  },


  ["jose-elias-alvarez/null-ls.nvim"] = {
    config = function()
      require "custom.plugins.null-ls"
    end,
    after = "nvim-lspconfig",
  },

  -- ["rcarriga/nvim-notify"] = {
  --   config = function ()
  --     require "notify".setup {
  --     }
  --   end,
  -- },
  -- ["windwp/nvim-ts-autotag"] = {
  --   config = function ()
  --     require'nvim-treesitter.configs'.setup {
  --     }
  --   end
  -- }
  -- ["stevearc/dressing.nvim"] = {
  --
  -- }
  ["Shatur/neovim-session-manager"] = {
    config = function ()
      local Path = require('plenary.path')
      require('session_manager').setup({
        sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
        path_replacer = '__', -- The character to which the path separator will be replaced for session files.
        colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          'gitcommit',
        },
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      })
    end
  },

  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = "make",
  }
}
