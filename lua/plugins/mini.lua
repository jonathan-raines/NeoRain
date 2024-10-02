return {
  {
    'echasnovski/mini.files',
    config = function()
      require 'mini.files'.setup {}
    end,
    keys = {
      { '<leader>e', '<cmd>lua MiniFiles.open()<CR>', desc = 'File Explorer' },
      -- {
      --   '-',
      --   '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>',
      --   desc = 'Mini Files Current Directory'
      -- }
    }
  },

  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

}
