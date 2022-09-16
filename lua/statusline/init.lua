local utils = require 'statusline.modules'

local M = {}

M.statusline = function()
  return table.concat {
    utils.Mode(),
    utils.Spacer(),
    utils.Git(),
    utils.Spacer(),
    '%=',
    utils.FileInfo(),
    '%=',
    utils.LSP_Diagnostics(),
    utils.Treesitter(),
    utils.LSP_status(),
    utils.Spacer()
  }
end

return M
