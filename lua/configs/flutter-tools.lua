require('flutter-tools').setup {
  lsp = {
    on_attach = require('lsp.handlers').on_attach(),
  },
}

require('which-key').register({
  f = {
    y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
  },
}, {
  prefix = '<leader>',
})
