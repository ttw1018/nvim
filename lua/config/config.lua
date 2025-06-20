local o = vim.o
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = " "

if jit.os == "Linux" then
  g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

o.clipboard = "unnamedplus"
o.undofile = true
o.swapfile = false
o.backup = false
-- o.cursorline = true
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.breakindent = true
-- o.linebreak = true
o.smoothscroll = true
o.number = true
o.relativenumber = true
o.scrolloff = 5

o.foldlevel = 99
o.foldlevelstart = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  virutal_text = true,
})

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
