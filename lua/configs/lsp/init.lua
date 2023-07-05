local signs = {
  { name = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignWarn',  text = ' ' },
  { name = 'DiagnosticSignHint',  text = '' },
  { name = 'DiagnosticSignInfo',  text = ' ' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp = pcall(require 'cmp_nvim_lsp')
if cmp_ok then
  capabilities = cmp.default_capabilities(capabilities)
end

local opts = {
  on_attach = function(client, bufnr)
    require 'configs.lsp.format'.setup(client)
    require 'configs.lsp.keymaps'.setup(bufnr)
  end,
  capabilities = capabilities,
}

local lspconfig = require 'lspconfig'
local server_settings = require 'configs.lsp.server_settings'

local servers = {
  ['bashls'] = {},
  ['clangd'] = {},
  ['eslint'] = {},
  ['jsonls'] = {},
  ['marksman'] = {},
  ['solargraph'] = {},
  ['lua_ls'] = server_settings.lua_ls(),
  ['tsserver'] = {
    init_options = {
      preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        importModuleSpecifierPreference = 'non-relative'
      },
    },
  },
  ['vuels'] = {},
  ['yamlls'] = {}
}

for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_extend('keep', lsp_opts, opts))
end
