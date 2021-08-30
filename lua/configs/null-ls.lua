local null_ls = require("null-ls")
local sources = {
  null_ls.builtins.formatting.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file(".eslintrc.js")
    end,
  }),
  null_ls.builtins.diagnostics.eslint_d,
}

require("null-ls").config({
  sources = sources
})

require("lspconfig")["null-ls"].setup({
  on_attach = function()
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
})
