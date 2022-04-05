local mappings = {
  j = {
    name = 'Terminal',
    d = { '<cmd>lua _LAZYDOCKER_TOGGLE()<CR>', 'Lazy Docker' },
    l = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazy Git' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
