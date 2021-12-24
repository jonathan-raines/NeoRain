require('lspconfig').solargraph.setup {
  on_attach = require('configs.lsp.handlers').on_attach,
  capabilities = require('configs.lsp.handlers').capabilities,
}
