local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    {
      'williamboman/mason.nvim',
      config = function()
        require 'mason'.setup()
      end,
      cmd = { 'Mason' }
    },
  },
  event = 'BufReadPre'
}

M.config = function()
  require 'configs.lsp'
end

return M
