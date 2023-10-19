return {
  'neovim/nvim-lspconfig',
  dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  config = function()
    require 'configs.lsp'
  end,
  event = 'VeryLazy'
}
