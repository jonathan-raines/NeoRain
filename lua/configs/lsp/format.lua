local M = {}

M.setup = function(client, bufnr)
  -- if client.name ~= 'eslint' then
  --   local navic = require 'nvim-navic'
  --   navic.attach(client, bufnr)
  -- end

  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == 'eslint' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Autoformat with eslint on save',
      buffer = 0,
      command = 'EslintFixAll'
    })
  elseif client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Autoformat buffer on save',
      buffer = 0,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end

  require 'configs.lsp.keymaps'.setup(bufnr)
end

return M
