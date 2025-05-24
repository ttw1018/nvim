return {
  {
    "ibhagwan/fzf-lua",
    version = "*",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "find file" },
      { "<leader>lg", "<cmd>FzfLua live_grep<cr>", desc = "live grep" },
      { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "help tags" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "old files" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "find buffer" },
      { "<leader>fd", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "show diagnostics" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "show jumplist" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "show marks" },
      { "<leader>tt", "<cmd>FzfLua<cr>", desc = "show fzflua" },
    },
    config = function()
      require("fzf-lua").setup({
        "default",
        fzf_colors = {
          true,
        },
        files = {
          fd_opts = [[--color=never --hidden --type f --type l --exclude .git --exclude node_modules]],
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
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "toggle neo-tree" },
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
        filesystem = {
          window = {
            position = "right",
            width = 25,
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
}
