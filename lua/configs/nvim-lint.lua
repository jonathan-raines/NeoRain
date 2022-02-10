local pattern = [[%s*(%d+):(%d+)%s+(%w+)%s+(.+%S)%s+(%S+)]]
local groups = { 'lnum', 'col', 'severity', 'message', 'code' }
local severity_map = {
  ['error'] = vim.diagnostic.severity.ERROR,
  ['warn'] = vim.diagnostic.severity.WARN,
  ['warning'] = vim.diagnostic.severity.WARN,
}

require('lint').linters.eslint_d = {
  cmd = 'eslint_d',
  args = { '--stdin-filename', vim.api.nvim_buf_get_name(0) },
  stdin = true,
  stream = 'stdout',
  ignore_exitcode = true,
  parser = require('lint.parser').from_pattern(pattern, groups, severity_map, { ['source'] = 'eslint' }),
}

require('lint').linters_by_ft = {
  javascript = { 'eslint' },
  vue = { 'eslint_d' },
}

vim.api.nvim_exec(
  [[
    augroup LintAutogroup
      autocmd!
      autocmd BufRead * lua require('lint').try_lint()
      autocmd InsertLeave * lua require('lint').try_lint()
      autocmd BufWritePost * lua require('lint').try_lint()
    augroup END
  ]],
  true
)
