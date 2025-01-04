local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'mbbill/undotree' }

later(function()
  vim.g.undotree_SetFocusWhenToggle = 1

  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })
end)
