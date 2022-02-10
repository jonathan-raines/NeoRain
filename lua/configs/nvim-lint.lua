require('lint').linters_by_ft = {
  javascript = { 'eslint' },
  vue = { 'eslint' },
}

vim.api.nvim_exec(
  [[
    augroup LintAutogroup
      autocmd!
      autocmd BufRead * lua require('lint').try_lint()
      autocmd BufWritePost * lua require('lint').try_lint()
    augroup END
  ]],
  true
)
