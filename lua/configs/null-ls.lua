---@diagnostic disable: undefined-global
local null_ls = require 'null-ls'
local sources = {
  null_ls.builtins.formatting.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file '.eslintrc.js'
    end,
  },
  null_ls.builtins.formatting.stylua.with {
    condition = function(utils)
      return utils.root_has_file '.stylua.toml'
    end,
  },
  null_ls.builtins.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file '.eslintrc.js'
    end,
  },
  null_ls.builtins.formatting.yapf,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.code_actions.refactoring,
}

require('null-ls').config {
  sources = sources,
}

require('lspconfig')['null-ls'].setup {
  on_attach = function()
    vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end,
}
