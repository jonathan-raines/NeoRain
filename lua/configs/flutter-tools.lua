local status_ok, flutter_tools = pcall(require, 'flutter-tools')
if not status_ok then
  return
end

flutter_tools.setup {
  lsp = {
    on_attach = require('lsp.handlers').on_attach(),
  },
}

local wk_status_ok, wk = pcall(require, 'which-key')
if not wk_status_ok then
  return
end

wk.register({
  f = {
    y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
  },
}, {
  prefix = '<leader>',
})
