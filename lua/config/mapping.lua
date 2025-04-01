local map = vim.keymap.set

map("i", "jk", "<Esc>", { silent = true, noremap = true })

map({ "n", "v" }, "J", "5j", { silent = true, noremap = true })
map({ "n", "v" }, "K", "5k", { silent = true, noremap = true })
map({ "n", "v" }, "L", "$", { silent = true, noremap = true })
map({ "n", "v" }, "H", "^", { silent = true, noremap = true })
map({ "n" }, "<leader><cr>", "<cmd>noh<cr>", { silent = true, noremap = true })
map({ "n" }, "<leader>w", "<cmd>bd<cr>", { silent = true, noremap = true })
map({ "n" }, "<leader>s", "<cmd>w<cr>", { silent = true, noremap = true })
map({ "n" }, "<leader>q", "<cmd>wqa<cr>", { silent = true, noremap = true })
map({ "n" }, "gl", "<cmd>bnext<cr>", { silent = true, noremap = true })
map({ "n" }, "gh", "<cmd>bprevious<cr>", { silent = true, noremap = true })
map({ "n", "v" }, "<leader>a", "za", { silent = true, noremap = true })

map({ "v", "n" }, "j", "gj", { silent = true, noremap = true })
map({ "v", "n" }, "k", "gk", { silent = true, noremap = true })

map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })
