return {}
return {
  {
    'stevearc/oil.nvim',
    dependencies = "echasnovski/mini.icons",
    init = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    config = function()
      require 'oil'.setup {}
    end
  },

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

}
