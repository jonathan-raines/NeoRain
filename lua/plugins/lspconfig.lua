return {
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
  config = function()
    require 'configs.lsp'
  end,
  event = 'BufReadPre'
}
