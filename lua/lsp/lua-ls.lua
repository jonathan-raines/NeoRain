local sumneko_path = "/Users/jonathanraines/.local/share/nvim/lspinstall/lua/sumneko-lua-language-server"

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
