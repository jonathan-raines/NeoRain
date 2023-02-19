local utils = require 'configs.statusline.modules'

--- Sets up the statusline
---@return string
function Statusline()
  return table.concat {
    utils.Mode(),
    utils.Spacer(),
    utils.Git(),
    utils.Spacer(),
    '%=',
    utils.FileInfo(),
    utils.Spacer(),
    utils.AlternateFile(),
    '%=',
    utils.Package_Updates(),
    utils.LSP_Diagnostics(),
    utils.LSP_status(),
    utils.Spacer(),
    utils.Treesitter(),
    utils.Spacer()
  }
end

vim.o.statusline = '%!v:lua.Statusline()'
