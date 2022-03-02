local lint = require 'lint'

lint.linters_by_ft = {
  javascript = { 'eslint' },
  vue = { 'eslint' },
}

vim.api.nvim_create_augroup('LintAutogroup', {})

vim.api.nvim_create_autocmd('BufRead', {
  desc = 'Run lint on BufRead',
  group = 'LintAutogroup',
  pattern = '*',
  callback = function()
    lint.try_lint()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Run lint on BufWritePost',
  group = 'LintAutogroup',
  pattern = '*',
  callback = function()
    lint.try_lint()
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Run lint on BufWritePost',
  group = 'LintAutogroup',
  pattern = '*',
  callback = function()
    lint.try_lint()
  end,
})
