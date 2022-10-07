local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "clangd", "cmake", "vimls", "tsserver", "gopls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      auxDirectory = "./output",
      build = {
        executable = "latexmk",
        args = {"-xelatex", "-outdir=output", "-synctex=1", "-interaction=nonstopmode", "%f"},
        onSave = false,
      },
      chktex = {
        onEdit = false,
      },
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = {"%l", "%p", "%f"},
      }
    }
  }
}



vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
