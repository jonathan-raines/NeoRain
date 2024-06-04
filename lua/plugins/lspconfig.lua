return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { "b0o/schemastore.nvim", ft = { 'json', 'yaml' } },
  },
  config = function()
    require 'lsp'
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
