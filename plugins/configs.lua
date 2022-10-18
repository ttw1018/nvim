local M = {}

M.nvterm = {
  terminals = {
    type_opts = {
      float = {
        row = 0.2,
        col = 0.1,
        width=0.8,
        height=0.6,
      }
    }
  }
}


M.treesitter = {
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = {
      "python"
    }
  }
}

M.cmp = function ()
  -- local cmp = require 'cmp'

  vim.opt.completeopt = "menu,preview,noselect"

  return {
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
    },
  }
end

M.ui = {
  -- statusline = {
  --   separator_style = "round",
  --   overriden_modules = nil,
  -- },
}

M.telescope = function ()
  local telescope = require("telescope")
  telescope.setup {
    pickers = {
      find_files = {
        find_command = {
          "rg",
          "--files",
          "--no-ignore",
          "-L",
        },
      }
    },
    extensions_list = { "fzf" }
  }
end

M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
  },
}

return M
