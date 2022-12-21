local M = { 'neovim/nvim-lspconfig' }

M.dependencies = 'hrsh7th/cmp-nvim-lsp'

M.event = 'BufReadPre'

M.config = function()
  require 'configs.lsp'
end

return M
