local flutter_tools = require 'flutter-tools'

flutter_tools.setup {
  lsp = {
    on_attach = require('lsp.handlers').on_attach(),
  },
}

local wk = require 'which-key'

wk.register({
  f = {
    y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
  },
}, {
  prefix = '<leader>',
})
