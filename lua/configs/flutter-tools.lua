require 'flutter-tools'.setup {
  lsp = {
    on_attach = require 'lsp.handlers'.on_attach(),
  },
}

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register({
    f = {
      y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
    },
  }, {
    prefix = '<leader>',
  })
end
