M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "esc to normal mode" },
  },
  n = {
    ["J"] = { "5j", "" },
    ["K"] = { "5k", "" },
    ["H"] = { "^", "" },
    ["L"] = { "$", "" },
    ["<C-h>"] = {
      function()
        require("Navigator").left()
      end,
      "move to left",
    },

    ["<C-l>"] = {
      function()
        require("Navigator").right()
      end,
      "move to right",
    },

    ["<C-j>"] = {
      function()
        require("Navigator").down()
      end,
      "move to down",
    },

    ["<C-k>"] = {
      function()
        require("Navigator").up()
      end,
      "move to up",
    },

    ["<leader>pp"] = { "<cmd> Preview <CR>", "preview markdown and latex pdf" },

    ["<leader>tt"] = { "<cmd> Telescope <CR>", "open telescope" },

    ["<space>w"] = { "<cmd> w <CR>", "save file" },

  },
  v = {
    ["J"] = { "5j", "" },
    ["K"] = { "5k", "" },
    ["H"] = { "^", "" },
    ["L"] = { "$", "" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>k"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },
    ["<leader>fs"] = { "<cmd> TexlabForward <CR>", "latex forward search" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.telescope = {
  n = {
    ["<leader>fl"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
  }
}

M.vimtex = {
  n = {
    ["<leader>ll"] = { "<cmd> VimtexCompile <CR>", "vimtex build" },
    ["<leader>to"] = { "<cmd> VimtexTocOpen <CR>", "textex toc" },
    ["<leader>le"] = { "<cmd> VimtexErrors <CR>", "vimtex errors" },
  }
}

M.disabled = {
  n = {
    ["<C-n>"] = "",
    ["K"] = "",
  },
}

return M