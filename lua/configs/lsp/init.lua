local signs = {
  { name = 'DiagnosticSignError', text = ' ' },
  { name = 'DiagnosticSignWarn',  text = ' ' },
  { name = 'DiagnosticSignHint',  text = '' },
  { name = 'DiagnosticSignInfo',  text = ' ' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    require 'configs.lsp.keymaps'.setup(ev.buf)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable completion triggered by <c-x><c-o>
    if client.server_capabilities.completionProvider then
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
    -- Enable inlay hints
    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint(ev.buf, true)
    -- end

    -- Enable format on save
    require 'configs.lsp.format'.setup(client)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp = pcall(require 'cmp_nvim_lsp')
if cmp_ok then
  capabilities = cmp.default_capabilities(capabilities)
end

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
  ['tsserver'] = server_settings.tsserver(),
  ['vuels'] = {},
  ['yamlls'] = {}
}

for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_extend('keep', lsp_opts, { capabilities = capabilities }))
end
