local utils = require 'statusline.modules'

function Statusline()
  return table.concat {
    utils.Mode(),
    utils.Spacer(),
    utils.Git(),
    utils.Spacer(),
    '%=',
    utils.FileInfo(),
    utils.AlternateFile(),
    '%=',
    utils.LSP_Diagnostics(),
    utils.Treesitter(),
    utils.LSP_status(),
    utils.Spacer()
  }
end

vim.o.statusline = '%!v:lua.Statusline()'
