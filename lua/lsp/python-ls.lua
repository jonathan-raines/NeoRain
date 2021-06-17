-- npm i -g pyright
require'lspconfig'.pyright.setup {
    cmd = {DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio"},
    on_attach = require'lsp'.common_on_attach,
    settings = {
      python = {
        analysis = {
		  typeCheckingMode = "basic",
		  autoSearchPaths = true,
          useLibraryCodeForTypes = true
        }
      }
    }
}
