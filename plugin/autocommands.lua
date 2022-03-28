vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text when yanking',
  group = 'YankHighlight',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
  end,
})

vim.api.nvim_create_augroup('TrimWhitespace', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'TrimWhitespace',
  pattern = '*',
  command = [[:%s/\s\+$//e]],
})

vim.api.nvim_create_augroup('CursorLocation', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  group = 'CursorLocation',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

vim.api.nvim_create_augroup('NeovimTerminal', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
  group = 'NeovimTerminal',
  pattern = '*',
  command = 'startinsert',
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = 'NeovimTerminal',
  pattern = '*',
  command = 'set nonumber norelativenumber nobuflisted',
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = 'NeovimTerminal',
  pattern = '*',
  command = 'nnoremap <buffer> <C-c> i<C-c>',
})

vim.api.nvim_create_autocmd('TermClose', {
  group = 'NeovimTerminal',
  pattern = '*',
  command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
})

vim.api.nvim_create_augroup('GeneralSettings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'GeneralSettings',
  pattern = 'help,man,lspinfo',
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>close<CR>')
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'No commenting new line',
  group = 'GeneralSettings',
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'GeneralSettings',
  pattern = 'qf',
  command = 'set nobuflisted',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Create missing directories before saving the buffer',
  group = 'GeneralSettings',
  callback = function()
    vim.fn.mkdir(vim.fn.expand '%:p:h', 'p')
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Thin border between windows on global statusline',
  group = 'GeneralSettings',
  command = 'highlight WinSeparator guibg=None',
})

vim.api.nvim_create_autocmd('WinEnter', {
  desc = 'Show cursorline in active window',
  group = 'GeneralSettings',
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  desc = 'Hide cursorline in inactive window',
  group = 'GeneralSettings',
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
