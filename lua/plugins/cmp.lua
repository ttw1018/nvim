return {
  {
    "saghen/blink.cmp",
    event = { "BufRead" },
    version = "*",
    opts = {
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        -- nerd_font_variant = "mono",
      },
      sources = {
        default = function()
          local ft = vim.bo.filetype
          if ft == "tex" or ft == "markdown" then
            return { "lsp", "path", "snippets" }
          else
            return { "lsp", "buffer", "path", "snippets" }
          end
        end,
      },
      completion = {
        list = {
          max_items = 30,
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
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
