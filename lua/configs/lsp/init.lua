require('configs.lsp.handlers').setup()

local opts = {
  on_attach = require('configs.lsp.handlers').on_attach,
  capabilities = require('configs.lsp.handlers').capabilities,
}

local lspconfig = require 'lspconfig'

local servers = {
  ['bashls'] = require 'configs.lsp.settings.bashls',
  ['clangd'] = {},
  ['eslint'] = require 'configs.lsp.settings.eslint',
  ['jsonls'] = require 'configs.lsp.settings.jsonls',
  ['solargraph'] = require 'configs.lsp.settings.solargraph',
  ['sumneko_lua'] = require 'configs.lsp.settings.sumneko_lua',
  ['tsserver'] = require 'configs.lsp.settings.tsserver',
  ['vuels'] = require 'configs.lsp.settings.vuels',
  ['yamlls'] = require 'configs.lsp.settings.yamlls',
}

for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_deep_extend('force', lsp_opts, opts))
end
