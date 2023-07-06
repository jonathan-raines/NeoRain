local M = {}

M.lua_ls = function()
  return {
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
  }
end

M.tsserver = function()
  return {
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
  }
end

return M
