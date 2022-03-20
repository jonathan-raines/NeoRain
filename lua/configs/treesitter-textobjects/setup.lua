local mappings = {
  d = {
    name = 'Peek',
    f = { 'Peek Function' },
    F = { 'Peek Class' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
