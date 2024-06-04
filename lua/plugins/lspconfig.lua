return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    "b0o/schemastore.nvim",
  },
  config = function()
    require 'lsp'
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
