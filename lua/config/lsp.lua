vim.lsp.enable("lua_ls")
vim.lsp.enable("texlab")
vim.lsp.enable("pyright")
vim.lsp.enable("clangd")
vim.lsp.enable("ts_ls")
vim.lsp.enable("cssls")
-- vim.lsp.enable("volar")
-- vim.lsp.enable("gopls")
-- vim.lsp.enable("rust_analyzer")
-- vim.lsp.enable("tailwindcss")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("mylsp", {}),
  callback = function(args)
    local map = vim.keymap.set
    map(
      "n",
      "gd",
      "<CMD>FzfLua lsp_definitions<CR>",
      { buffer = args.buf, noremap = true, silent = true, desc = "goto definition" }
    )
    map(
      "n",
      "gi",
      "<CMD>FzfLua lsp_implementations<CR>",
      { buffer = args.buf, noremap = true, silent = true, desc = "goto implementation" }
    )
    map(
      "n",
      "gr",
      "<CMD>FzfLua lsp_references<CR>",
      { buffer = args.buf, noremap = true, silent = true, desc = "goto reference" }
    )

    map(
      "n",
      "<leader>ca",
      "<CMD>FzfLua lsp_code_actions<CR>",
      { buffer = args.buf, noremap = true, silent = true, desc = "lsp code action" }
    )
    map(
      "n",
      "<leader>rn",
      vim.lsp.buf.rename,
      { buffer = args.buf, noremap = true, silent = true, desc = "lsp rename" }
    )
    map("n", "<leader>k", vim.lsp.buf.hover, { buffer = args.buf, noremap = true, silent = true, desc = "show hover" })
    map(
      "n",
      "<leader>d",
      vim.diagnostic.open_float,
      { buffer = args.buf, noremap = true, silent = true, desc = "open diagnostic" }
    )
  end,
})
