return {
  {
    "folke/tokyonight.nvim",
    version = "*",
    priority = 1000,
    lazy = true,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        style = "day",
        transparent = true,
        on_highlights = function(hl, _)
          hl.TabLineFill = {
            bg = "#E4E4E4",
          }
          hl.TabLineSel = {
            fg = "#2e7de9",
            bg = "#a8aecb",
          }
          hl.TabLine = {
            fg = "#6172b0",
            bg = "#d0d5e3",
          }
          hl.GitSignsAdd = {
            fg = "green",
          }
          hl.GitSignsChange = {
            fg = "orange",
          }
          hl.GitSignsDelete = {
            fg = "red",
          }
          -- hl.WinBar = {
          --   nil,
          -- }
        end,
      })
      tokyonight.load()
    end,
  },

  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
    priority = 1000,
    config = function()
      local everforest = require("everforest")
      everforest.setup({
        background = "light",
      })
      everforest.load()
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local nightfox = require("nightfox")
      nightfox.setup({
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        groups = {
          all = {
            GitSignsAdd = {
              fg = "green",
            },
            GitSignsChange = {
              fg = "orange",
            },
            GitSignsDelete = {
              fg = "red",
            },
          },
        },
      })
      vim.cmd.colorscheme("dayfox")
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
    config = function()
      vim.cmd.colorscheme("catppuccin-latte")
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "folke/snacks.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      {
        "<leader>mp",
        "<cmd>lua Snacks.notifier.show_history()<cr>",
        desc = "show message history",
      },
    },
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = true },
      notifier = { enabled = true, top_down = false },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "*",
    event = "BufReadPre",
    cond = function()
      local git_dir = vim.fs.find(".git", { upward = true, type = "directory" })
      return not vim.tbl_isempty(git_dir)
    end,
    opts = {
      signs = {
        -- "┃" "▎"
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "┃" },
        untracked = { text = "┃" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "┃" },
      },
      on_attach = function()
        local gitsigns = require("gitsigns")
        local map = vim.keymap.set
        map("n", "<leader>gd", function()
          gitsigns.diffthis("~")
        end, { desc = "git diff file" })
        map("n", "<leader>gp", gitsigns.preview_hunk_inline, { desc = "git preview hunk" })
        map("n", "<leader>gr", function()
          gitsigns.reset_hunk()
        end, { desc = "git reset hunk" })
      end,
    },
  },
  {
    "folke/noice.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      cmdline = {
        format = {
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = "60%",
            height = "auto",
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "file" },
        { "<leader>g", group = "git" },
        { "<leader>m", group = "message" },
        { "<leader>m", group = "toggle" },
        { "<leader>c", group = "lsp code action" },
        { "<leader>r", group = "lsp rename" },
      })
    end,
  },
}
