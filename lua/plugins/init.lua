return {
  'nvim-tree/nvim-web-devicons',

  'sindrets/diffview.nvim',

  { "b0o/schemastore.nvim", lazy = true },

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({})
    end,
    ft = { 'markdown' }
  },

  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end
  },

  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {
        render = 'virtual',
      }
    end
  },

}
