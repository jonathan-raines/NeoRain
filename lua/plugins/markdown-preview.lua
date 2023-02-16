return {
  'iamcco/markdown-preview.nvim',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    { 'n', '<leader>p', '<cmd>MarkdownPreview<CR>', desc = 'Markdown Preview' }
  },
  ft = 'markdown'
}
