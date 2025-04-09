return {
  {
    "folke/tokyonight.nvim",
    version = "*",
    lazy = false,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        style = "day",
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
        end,
      })
      tokyonight.load()
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
      notifier = { enabled = true },
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
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function()
        local gitsigns = require("gitsigns")
        local map = vim.keymap.set
        map("n", "<leader>gd", function()
          gitsigns.diffthis("~")
        end)
        map("n", "<leader>gp", gitsigns.preview_hunk_inline)
      end,
    },
  },
}
