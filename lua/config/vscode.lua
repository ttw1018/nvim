local vscode = require("vscode")
local map = vim.keymap.set

local delmap = vim.keymap.del

delmap("n", "<C-h>", { silent = true, noremap = true })
delmap("n", "<C-j>", { silent = true, noremap = true })
delmap("n", "<C-k>", { silent = true, noremap = true })
delmap("n", "<C-l>", { silent = true, noremap = true })
delmap({ "n" }, "<leader>w", { silent = true, noremap = true, desc = "close buffer" })

map({ "n" }, "gl", function()
  vscode.action("workbench.action.nextEditor")
end, { silent = true, noremap = true, desc = "next buffer" })

map({ "n" }, "gh", function()
  vscode.action("workbench.action.previousEditor")
end, { silent = true, noremap = true, desc = "previous buffer" })

map({ "n", "v" }, "<leader>rn", function()
  vscode.action("editor.action.rename")
end, { silent = true, noremap = true })

map({ "n", "v" }, "<leader>k", function()
  vscode.action("editor.action.showHover")
end, { silent = true, noremap = true })

map({ "n", "v" }, "<leader>fm", function()
  vscode.action("editor.action.format")
end, { silent = true, noremap = true })

local gh = function(x)
  return "https://github.com/" .. x
end

map({ "n", "x", "o" }, "F", "<cmd>HopChar1<cr>", { silent = true, noremap = true })

vim.pack.add({
  gh("hadronized/hop.nvim"),
  gh("kylechui/nvim-surround"),
})

require("hop").setup()
