return {
  {
    "ibhagwan/fzf-lua",
    version = "*",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>" },
      { "<leader>lg", "<cmd>FzfLua live_grep<cr>" },
      { "<leader>fh", "<cmd>FzfLua helptags<cr>" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>" },
      { "<leader>fd", "<cmd>FzfLua lsp_workspace_diagnostics<cr>" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>" },
      { "<leader>tt", "<cmd>FzfLua<cr>" },
    },
    config = function()
      require("fzf-lua").setup({
        "default",
        fzf_colors = {
          true,
        },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = true,
    keys = {
      { "<leader>e", "<cmd>Neotree<cr>" },
    },
    config = function()
      local uname = jit.os
      local system_open_cmd = nil
      if uname == "OSX" then
        system_open_cmd = "open"
      elseif uname == "Linux" then
        system_open_cmd = "xdg-open"
      else
        system_open_cmd = "open"
      end
      require("neo-tree").setup({
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        filesystem = {
          window = {
            position = "right",
            mappings = {
              ["O"] = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.jobstart({ system_open_cmd, path }, { detach = true })
              end,
            },
          },
        },
      })
    end,
  },

  {
    "swaits/zellij-nav.nvim",
    lazy = true,
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left" } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
      { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    },
    opts = {},
  },
}
