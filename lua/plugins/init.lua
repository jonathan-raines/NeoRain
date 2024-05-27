return {

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
    ft = { 'markdown' }
  },

  {
    'brenoprata10/nvim-highlight-colors',
    opts = { render = 'virtual' },
    event = 'BufRead'
  },

}
