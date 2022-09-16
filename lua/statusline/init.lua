local utils = require 'statusline.modules'

local M = {}

M.statusline = function()
  return table.concat {
    utils.Mode(),
    utils.Git(),
    '%=',
    utils.FileInfo(),
    '%=',
    utils.LSP_Diagnostics(),
    utils.Treesitter(),
    utils.LSP_status(),
  }
end

return M
