local o = vim.o
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = " "
o.clipboard = "unnamedplus"
o.undofile = true
o.swapfile = false
o.backup = false
o.cursorline = true
o.background = "light"
o.shiftwidth = 2
o.smoothscroll = true
o.breakindent = true
o.linebreak = true

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
    o.spell = true
    o.shiftwidth = 8

    local map = vim.keymap.set
    map("n", "<leader>jj", "<cmd>TexlabForward<cr>")
    map("n", "<leader>rn", "<cmd>TexlabChangeEnvironment<cr>")
    map("n", "<leader>ll", "<cmd>VimtexCompile<cr>")
  end,
})

autocmd("FileType", {
  pattern = { "vue" },
  callback = function()
    vim.bo.commentstring = "<!-- %s -->"
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
