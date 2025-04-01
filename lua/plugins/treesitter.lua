return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  event = "BufRead",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      sync_install = true,
      highlight = {
        enable = true,
        user_language_tree = true,
        disable = function(_, buf)
          local max_filesize = 50 * 1024 * 1024 -- 100 MB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
