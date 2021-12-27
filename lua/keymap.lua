local options = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap
map('i', 'jk', '<esc>', options)
map('n', '<space><enter>', ':nohl<cr>', options)
map('', 'k', 'gk', options)
map('', 'j', 'gj', options)
map('', 'L', '$', options)
map('', 'H', '^', options)
map('', 'J', '5gj', options)
map('', 'K', '5gk', options)
map('n', '<space>t', '<cmd>NvimTreeToggle<cr>', options)
