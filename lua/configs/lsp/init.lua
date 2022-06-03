local handlers = require('configs.lsp.handlers')

handlers.setup()

local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

local lspconfig = require 'lspconfig'
local server_settings = require 'configs.lsp.server_settings'

local servers = {
  ['bashls'] = {},
  ['clangd'] = {},
  ['eslint'] = {},
  ['jsonls'] = server_settings.jsonls(),
  ['solargraph'] = {},
  ['sumneko_lua'] = server_settings.sumneko_lua(),
  ['tsserver'] = {},
  ['vuels'] = {},
  ['yamlls'] = {}
}

for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_deep_extend('force', lsp_opts, opts))
end
