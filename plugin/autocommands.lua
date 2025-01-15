--  ╭─────────────────────────────────────────────────────────╮
--  │                     Autocommands                        │
--  ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Go to the last location when opening a buffer',
  group = vim.api.nvim_create_augroup('Last Edit Position', { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd 'normal! g`"zz'
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text on yank',
  group = vim.api.nvim_create_augroup('Yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
  end
})
