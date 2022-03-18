local mappings = {
  j = {
    name = 'Terminal',
    l = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
