local M = {
  'akinsho/flutter-tools.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  ft = { 'dart' }
}

M.config = function()
  require 'flutter-tools'.setup {}
end

return M
