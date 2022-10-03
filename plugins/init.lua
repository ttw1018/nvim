
local custom_config = require("custom.plugins.configs")

return {

  -- ["folke/which-key.nvim"] = {
  --   disable = false,
  -- },
  --
  -- ["NvChad/nvterm"] = {
  --   disable = true,
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
        }
      })
    end,
    ft = {'md', 'markdown'}
  },

  ["ttw1018/markdown-preview.nvim"] = {
    ft = {'md', 'markdown', 'tex', 'bib', 'latex' }
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
    -- after = "cmp-buffer",
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

}
