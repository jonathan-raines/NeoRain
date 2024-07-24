return {
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      -- { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

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
    config = true
  },

  {
    "oysandvik94/curl.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("curl").setup({})
    end,
    cmd = 'CurlOpen'
  },

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    config = function()
      require('render-markdown').setup({})
    end,
    ft = 'markdown'
  },

}
