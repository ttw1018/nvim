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
        fzf_colors = {
          true,
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  {
    "numToStr/Navigator.nvim",
    version = "*",
    keys = {
      { "<C-h>", "<cmd>NavigatorLeft<cr>" },
      { "<C-l>", "<cmd>NavigatorRight<cr>" },
      { "<C-k>", "<cmd>NavigatorUp<cr>" },
      { "<C-j>", "<cmd>NavigatorDown<cr>" },
    },
    config = function()
      require("Navigator").setup()
    end,
  },
}
