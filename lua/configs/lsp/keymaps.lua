local M = {}

M.setup = function(bufnr)
  local keymap = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  local fzf = require('fzf-lua')

  -- Actions
  keymap('n', '<leader>la', vim.lsp.buf.code_action, 'Code Action')
  keymap('n', '<leader>lr', vim.lsp.buf.rename, 'Rename')
  keymap('n', '<leader>lf', vim.lsp.buf.format, 'Format')
  -- Diagnostics
  keymap('n', '<leader>ll', vim.diagnostic.setloclist, 'Set Local List')
  keymap('n', '<leader>ld', vim.diagnostic.open_float, 'Line Diagnostics')
  keymap('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostics')
  keymap('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostics')
  -- Help
  keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
  keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  -- Jump
  keymap('n', 'gd', fzf.lsp_definitions, 'Definition')
  keymap('n', 'gD', vim.lsp.buf.declaration, 'Declaration')
  keymap('n', '<leader>s', fzf.lsp_document_symbols, 'Document Symbols')
  keymap('n', 'gi', vim.lsp.buf.implementation, 'Implementation')
  keymap('n', 'gr', fzf.lsp_references, 'References')
  keymap('n', '<leader>S', fzf.lsp_workspace_symbols, 'Workspace Symbols')
end

return M
