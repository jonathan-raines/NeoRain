return {
  -- TODO: Remove
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
    keys = {
      { '<leader>do', vim.cmd.DiffviewOpen,  desc = '[Diffview] Open' },
      { '<leader>dc', vim.cmd.DiffviewClose, desc = '[Diffview] Close' }
    },
  },

  -- Git integration.
  {
    'echasnovski/mini-git',
    main = 'mini.git',
    config = true,
    keys = {
      {
        '<leader>gd',
        function()
          require('mini.git').show_at_cursor {}
        end,
        desc = 'Show info at cursor',
        mode = { 'n', 'x' },
      },
    },
  },
}
