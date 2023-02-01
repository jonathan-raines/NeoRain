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
    {
      'glepnir/lspsaga.nvim',
      config = function()
        require 'lspsaga'.setup {}
      end,
      dependencies = { { 'kyazdani42/nvim-web-devicons' } },
    },
  },
  event = 'BufReadPre'
}

M.config = function()
  require 'configs.lsp'
end

return M
