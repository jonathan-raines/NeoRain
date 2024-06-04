vim.o.completeopt = 'menu,menuone,noselect'

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if vim.snippet.active({ direction = 1 }) then
    return '<cmd>lua vim.snippet.jump(1)<cr>'
  else
    return '<Tab>'
  end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if vim.snippet.active({ direction = -1 }) then
    return '<cmd>lua vim.snippet.jump(-1)<cr>'
  else
    return '<Tab>'
  end
end, { expr = true })
