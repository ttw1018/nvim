if not vim.g.vscode then
  require("config.lazy")
  require("config.lsp")
end

require("config.config")
require("config.mapping")
