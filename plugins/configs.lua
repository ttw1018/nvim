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
}

M.cmp = function ()
  -- local cmp = require 'cmp'

  return {
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = 'emoji' },
    },

    -- mappings = {
    --   ["<CR>"] = cmp.mapping.confirm {
    --     select = false,
    --   },
    -- }
  }
end

M.ui = {
  statusline = {
    separator_style = "round",
    overriden_modules = nil,
  },
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
  }
end

M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
  },
}

return M
