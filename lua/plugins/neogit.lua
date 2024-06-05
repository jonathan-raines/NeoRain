return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "ibhagwan/fzf-lua",       -- optional
    "sindrets/diffview.nvim", -- optional - Diff integration
  },
  config = true,
  cmd = "Neogit",
  keys = { { '<leader>gg', vim.cmd.Neogit, desc = 'Open Neogit' } }
}
