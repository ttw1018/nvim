local map = vim.keymap.set

map("i", "jk", "<Esc>", { silent = true, noremap = true })

map({ "n", "v" }, "J", "5j", { silent = true, noremap = true })
map({ "n", "v" }, "K", "5k", { silent = true, noremap = true })
map({ "n", "v" }, "L", "g$", { silent = true, noremap = true })
map({ "n", "v" }, "H", "g^", { silent = true, noremap = true })
map({ "n" }, "<leader><cr>", "<cmd>noh<cr>", { silent = true, noremap = true, desc = "no highlight" })
map({ "n" }, "<leader>w", "<cmd>bd<cr>", { silent = true, noremap = true, desc = "close buffer" })
map({ "n" }, "<leader>s", "<cmd>w<cr>", { silent = true, noremap = true, desc = "save buffer" })
map({ "n" }, "<leader>q", "<cmd>wqa<cr>", { silent = true, noremap = true, desc = "quit neovim" })
map({ "n" }, "gl", "<cmd>bnext<cr>", { silent = true, noremap = true, desc = "next buffer" })
map({ "n" }, "gh", "<cmd>bprevious<cr>", { silent = true, noremap = true, desc = "previous buffer" })
map({ "n", "v" }, "<leader>a", "za", { silent = true, noremap = true, desc = "fold block" })

map({ "v", "n" }, "j", "gj", { silent = true, noremap = true })
map({ "v", "n" }, "k", "gk", { silent = true, noremap = true })

map("n", "<leader>/", "gcc", { remap = true, desc = "comment line" })
map("v", "<leader>/", "gc", { remap = true, desc = "comment line" })

map("n", "<C-h>", "<C-W>h", { silent = true, noremap = true })
map("n", "<C-j>", "<C-W>j", { silent = true, noremap = true })
map("n", "<C-k>", "<C-W>k", { silent = true, noremap = true })
map("n", "<C-l>", "<C-W>l", { silent = true, noremap = true })
