local servers = {
  ['bashls'] = {},
  ['clangd'] = {},
  ['eslint'] = {},
  ['jsonls'] = {},
  ['marksman'] = {},
  ['lua_ls'] = {
    settings = {
      Lua = {
        hint = {
          enable = true
        },
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          enable = true,
          globals = { 'vim', 'use', 'bufnr' },
        },
        workspace = {
          checkcheckThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
  ['solargraph'] = {},
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

local lspconfig = require 'lspconfig'

-- Server Setup
for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_extend('force', lsp_opts, {}))
end
