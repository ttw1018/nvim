local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "clangd", "cmake", "vimls", "tsserver", "gopls", "marksman" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      }
    }
  }
}

-- lspconfig.pyre.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      auxDirectory = "./output",
      build = {
        executable = "latexmk",
        args = { "-xelatex", "-shell-escape", "-output-directory=output", "-synctex=1", "-interaction=nonstopmode", "%f" },
        onSave = true,
      },
      chktex = {
        onEdit = false,
      },
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "%l", "%p", "%f" },
      },
    },
  },
}

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}
