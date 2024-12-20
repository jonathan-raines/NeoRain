local servers = {
  ['bashls'] = {},
  ['clangd'] = {},
  ['eslint'] = {},
  ['jsonls'] = {
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
          end,
        },
      },
    },
  },
  ['lua_ls'] = {
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { 'vim', 'use' },
          disable = { 'missing-fields' }
        },
        hint = { enable = true },
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        completion = {
          callSnippet = 'Replace',
        },
        telemetry = { enable = false },
      },
    },
  },
  ['marksman'] = {},
  -- ['ruby_lsp'] = {
  --   init_options = {
  --     formatter = 'rubocop',
  --     linters = { 'rubocop' }
  --   }
  -- },
  ['solargraph'] = {},
  ['ts_ls'] = {
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
