return {
  {
    'brenoprata10/nvim-highlight-colors',
    opts = { render = 'virtual' },
    event = 'BufRead'
  },

  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {},
  },

  {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true
  }

}
