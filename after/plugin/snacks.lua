local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'folke/snacks.nvim' }

later(function()
  require 'snacks'.setup {
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true }
  }

  vim.keymap.set('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit Current File History' })
  vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
  vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = 'Lazygit Log (cwd)' })
  vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
end)
