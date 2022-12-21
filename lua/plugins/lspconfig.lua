local M = {
  'neovim/nvim-lspconfig',
  dependencies = 'hrsh7th/cmp-nvim-lsp',
  event = 'BufReadPre'
}

M.config = function()
  require 'configs.lsp'
end

return M
