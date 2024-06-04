return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "b0o/schemastore.nvim",
  },
  config = function()
    require 'lsp'
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
