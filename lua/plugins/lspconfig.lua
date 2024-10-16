return {
  'neovim/nvim-lspconfig',
  config = function()
    require 'lsp'
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
