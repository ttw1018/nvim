return {
  {
    "saghen/blink.cmp",
    event = { "BufRead" },
    dependencies = { "fang2hou/blink-copilot" },
    version = "*",
    opts = {
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      signature = {
        enabled = true,
      },
      sources = {
        default = function()
          local ft = vim.bo.filetype
          if ft == "tex" or ft == "markdown" then
            return { "lsp", "path", "snippets" }
          else
            return { "lsp", "copilot", "buffer", "path", "snippets" }
          end
        end,
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
      completion = {
        list = {
          max_items = 50,
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
      },
      fuzzy = {
        implementation = "rust",
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWrite" },
    version = "*",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        tex = { "latexindent" },
        python = { "ruff_format" },
        vue = { "prettierd" },
        typescript = { "prettierd" },
        javascript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
