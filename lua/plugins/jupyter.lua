return {
  "benlubas/molten-nvim",
  disable = true,
  version = "^1.0.0",
  build = ":UpdateRemotePlugins",
  init = function()
    -- this is an example, not a default. Please see the readme for more configuration options
    vim.g.molten_output_win_max_height = 12
  end,
  config = function() end,
}
