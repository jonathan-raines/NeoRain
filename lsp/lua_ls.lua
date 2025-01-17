---@type table<string, vim.lsp.Config>
return {
  cmd = { "lua-language-server" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim', 'use', 'MiniDeps', 'Snacks' },
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
  }
}
