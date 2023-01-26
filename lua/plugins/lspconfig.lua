local M = {
  'neovim/nvim-lspconfig',
  dependencies = { 'hrsh7th/cmp-nvim-lsp', 'mason.nvim' },
  event = 'BufReadPre'
}

M.config = function()
  require 'configs.lsp'
end

return M
