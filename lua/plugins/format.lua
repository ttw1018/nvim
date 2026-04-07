return {
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
      sh = { "shfmt" },
    },
    formatters = {
      shfmt = {
        command = "shfmt",
        args = { "-i", "2", "-ci", "-s" },
        stdin = true,
      },
    },
    -- format_on_save = {
    --   async = true,
    --   timeout_ms = 3000,
    --   lsp_format = "fallback",
    -- },
  },
}
