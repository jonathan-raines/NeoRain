require'lspconfig'.sumneko_lua.setup {
    cmd = {DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server"},
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
