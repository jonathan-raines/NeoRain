return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "ibhagwan/fzf-lua",       -- optional
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    config = true,
    cmd = "Neogit",
    keys = {
      { '<leader>gg', vim.cmd.Neogit, desc = 'Open Neogit' }
    }
  },

  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    keys = {
      { '<leader>gs', [[:tab G<CR>]], desc = '[Fugitive] Status' },
      -- { '<leader>gb', [[:G blame<CR>]], desc = '[Fugitive] Blame' },
    },
  },

}
