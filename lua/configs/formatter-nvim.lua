require('formatter').setup {
  filetype = {
    javascript = {
      function()
        return {
          exe = 'eslint_d',
          args = { '--stdin', '--stdin-filename', '"%:p"', '--fix-to-stdout' },
          stdin = true,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = 'stylua',
          args = { '-' },
          stdin = true,
        }
      end,
    },
    vue = {
      function()
        return {
          exe = 'eslint_d',
          args = { '--stdin-filename', vim.api.nvim_buf_get_name(0), '--fix', '--cache' },
          stdin = false,
        }
      end,
    },
  },
}

vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Use external formatter to format buffer',
  group = 'FormatAutogroup',
  pattern = '*.js,*.vue,*.lua',
  command = 'FormatWrite',
})
