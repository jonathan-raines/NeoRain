return {
  { 'nvim-tree/nvim-web-devicons' },

  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = function()
      require('symbol-usage').setup {
        vt_position = 'end_of_line'
      }
    end
  },

}
