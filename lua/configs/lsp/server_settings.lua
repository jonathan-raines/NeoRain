local servers = {
  ['bashls'] = {},
  ['clangd'] = {},
  ['eslint'] = {},
  ['jsonls'] = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
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
  ['marksman'] = {},
  ['lua_ls'] = {
    settings = {
      Lua = {
        hint = {
          enable = true
        },
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          enable = true,
          globals = { 'vim', 'use', 'bufnr' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.stdpath "config" .. "/lua"] = true,
          },
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
  -- ['yamlls'] = {}
}

local lspconfig = require 'lspconfig'

-- Server Setup
for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_extend('force', lsp_opts, {}))
end
