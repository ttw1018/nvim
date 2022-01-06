local function skip_pairs()
	local line = vim.api.nvim_get_current_line()
	local cursor = vim.api.nvim_win_get_cursor(0)[2]
	local current = string.sub(line, cursor + 1, cursor + 1)
	if current == '"' or current == "'" or current == ")" or current == "]" or current == "}" then
		return true
	else
		return false
	end
end


local present, cmp = pcall(require, "cmp")

if not present then
   return
end

vim.opt.completeopt = "menu,menuone,preview"

cmp.setup {
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   formatting = {
      format = function(entry, vim_item)
         local icons = require "plugins.configs.lspkind_icons"
         vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
         })[entry.source.name]

         return vim_item
      end,
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      -- ["<Tab>"] = function(fallback)
      --    if cmp.visible() then
      --       cmp.select_next_item()
      --    elseif require("luasnip").expand_or_jumpable() then
      --       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      --    else
      --       fallback()
      --    end
      -- end,
      --
      
      ["<Tab>"] = function(fallback)
              if cmp.visible() then
                      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
              elseif skip_pairs() then
                      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<right>", true, true, true), "i", true)
              else
                      fallback()
              end
      end,
      ["<S-Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
   },
  completion = {
      completeopt = "menu,menuone,preview",
  },
}
