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

  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        transparent = true, -- Show/hide background
      }
      require('bamboo').load()
    end,
  },
}
