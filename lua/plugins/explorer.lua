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
    "nvim-tree/nvim-tree.lua",
    version = "*",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>" },
    },
    config = function()
      require("nvim-tree").setup({
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        view = {
          side = "right",
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
