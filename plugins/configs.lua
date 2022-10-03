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
  ensure_installed = {
    "lua",
    "c",
    "markdown",
    "python",
    "markdown_inline",
    "bash",
    "cpp",
    "fish"
  }
}

M.cmp = function ()
  local cmp = require 'cmp'

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
  return {
    -- window = {
    --   documentation = {
    --     border = border("DocWin")
    --   }
    -- },
    -- completion = {
    --   completeopt = "menu,menuone,preview,noinsert,noselect",
    -- },

    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      -- { name = "spell" },
      { name = 'emoji' },
    },

    mappings = {
      ["<CR>"] = cmp.mapping.confirm {
        select = false,
      },
    }
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
          "--no-ignore"
        },
      }
    }
  }
end


return M
