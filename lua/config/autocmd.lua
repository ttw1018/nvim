local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "tex" },
  callback = function()
    vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>", { buffer = true })
    vim.keymap.set("n", "<leader>jj", "<cmd>VimtexView<cr>", { buffer = true })
  end,
})

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 1 and last_pos <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
    end
  end,
})

autocmd("BufEnter", {
  pattern = "*dap-repl*",
  callback = function()
    vim.keymap.set("n", "c", "<cmd>DapContinue<cr>", { buffer = true })
    vim.keymap.set("n", "n", "<cmd>DapStepOver<cr>", { buffer = true })
    vim.keymap.set("n", "o", "<cmd>DapStepOut<cr>", { buffer = true })
    vim.keymap.set("n", "i", "<cmd>DapStepInto<cr>", { buffer = true })
    vim.keymap.set("n", "p", "<cmd>DapPause<cr>", { buffer = true })
    vim.keymap.set("n", "q", "<cmd>DapTerminate<cr>", { buffer = true })
  end,
})

