local M = {}

M.lua_ls = function()
  return {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          enable = true,
          globals = { 'vim', 'use' },
        },
        workspace = {
          checkcheckThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  }
end

return M
