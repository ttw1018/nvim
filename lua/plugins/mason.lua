return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufRead",
  version = "*",
  config = function()
    require("mason").setup()
  end,
}
