require('flutter-tools').setup {
  lsp = {
    on_attach = _G_custom_on_attach,
  },
}

require('which-key').register({
  f = {
    y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
  },
}, {
  prefix = '<leader>',
})
