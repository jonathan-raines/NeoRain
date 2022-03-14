require('flutter-tools').setup {
  lsp = {
    on_attach = require('lsp.handlers').on_attach(),
  },
}

local wk_ok, wk = pcall(require, 'which-key')
if not wk_ok then
  return
end

wk.register({
  f = {
    y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
  },
}, {
  prefix = '<leader>',
})
