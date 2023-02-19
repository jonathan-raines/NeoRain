local M = {}

M.sumneko_lua = function()
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
          library = vim.api.nvim_get_runtime_file('', true),
          maxPreload = 10000,
          preloadFileSize = 10000,
        },
        telemetry = { enable = false },
      },
    },
  }
end

return M
