vim.o.completeopt = 'menu,menuone,noselect'

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if vim.snippet.jumpable(1) then
    return '<cmd>lua vim.snippet.jump(1)<cr>'
  end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if vim.snippet.jumpable(-1) then
    return '<cmd>lua vim.snippet.jump(-1)<cr>'
  end
end, { expr = true })
