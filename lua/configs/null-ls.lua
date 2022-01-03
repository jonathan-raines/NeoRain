local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local sources = {
  null_ls.builtins.code_actions.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file '.eslintrc.js'
    end,
    prefer_local = 'node_modules/.bin',
  },
  null_ls.builtins.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file '.eslintrc.js'
    end,
    prefer_local = 'node_modules/.bin',
  },
  null_ls.builtins.formatting.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file '.eslintrc.js'
    end,
    prefer_local = 'node_modules/.bin',
  },
  null_ls.builtins.formatting.stylua.with {
    condition = function(utils)
      return utils.root_has_file '.stylua.toml'
    end,
  },
  null_ls.builtins.formatting.prettier.with {
    filetypes = { 'eruby' },
  },
  null_ls.builtins.formatting.yapf,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.code_actions.refactoring,
}

null_ls.setup {
  sources = sources,
  on_attach = function()
    vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end,
}
