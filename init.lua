require("config.config")
require("config.mapping")

if not vim.g.vscode then
  require("config.lazy")
  require("config.lsp")
else
  require("config.vscode")
end

