local servers = {
  ['bashls'] = {},
  ['clangd'] = {},
  ['eslint'] = {},
  ['jsonls'] = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
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
  ['lua_ls'] = {
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { 'vim', 'use', 'bufnr' },
        },
        hint = { enable = true },
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          -- Tells lua_ls where to find all the Lua files that you have loaded
          -- for your neovim configuration.
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
          -- If lua_ls is really slow on your computer, you can try this instead:
          -- library = { vim.env.VIMRUNTIME },
        },
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
        telemetry = { enable = false },
      },
    },
  },
  ['marksman'] = {},
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
  ['yamlls'] = {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  }
}

local lspconfig = require 'lspconfig'

-- Server Setup
for lsp, lsp_opts in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_extend('force', lsp_opts, {}))
end
