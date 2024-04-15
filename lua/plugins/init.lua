return {
  'nvim-tree/nvim-web-devicons',

  'vimpostor/vim-tpipeline',

  { "b0o/schemastore.nvim", lazy = true },

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({})
    end,
  },

}
