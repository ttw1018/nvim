return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "InsertEnter",
    config = true,
  },
  {
    "hadronized/hop.nvim",
    version = "*",
    keys = {
      { "F", mode = { "n", "x", "o" }, "<cmd>HopChar1<cr>" },
    },
    config = function()
      require("hop").setup()
    end,
  },
}
