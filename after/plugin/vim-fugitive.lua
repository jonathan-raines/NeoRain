MiniDeps.add { source = 'tpope/vim-fugitive' }

MiniDeps.later(function()
  vim.keymap.set('n', '<leader>gs', [[:tab G<CR>]], { desc = '[Fugitive] Status' })
end)
