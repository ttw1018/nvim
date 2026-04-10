return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
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
            return { "lsp", "buffer", "path", "snippets" }
          end
        end,
        providers = {},
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
}
