local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'tpope/vim-fugitive' }

later(function()
  vim.keymap.set('n', '<leader>gs', [[:tab G<CR>]], { desc = '[Fugitive] Status' })
end)
