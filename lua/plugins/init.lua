return {
  {
    'brenoprata10/nvim-highlight-colors',
    opts = { render = 'virtual' },
    cmd = { 'HighlightColors' }
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
  },

  {
    "oysandvik94/curl.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("curl").setup({})
    end,
    cmd = 'CurlOpen'
  }

}
