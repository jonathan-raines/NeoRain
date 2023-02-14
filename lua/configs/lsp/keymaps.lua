local M = {}

M.setup = function(bufnr)
  local keymap = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  -- Actions
  keymap('n', '<leader>lca', vim.lsp.buf.code_action, 'Code Action')
  keymap('n', '<leader>lrn', vim.lsp.buf.rename, 'Rename')
  keymap('n', '<leader>lf', vim.lsp.buf.format, 'Format')
  -- Diagnostics
  keymap('n', '<leader>ll', vim.diagnostic.setloclist, 'Set Local List')
  keymap('n', '<leader>ldi', vim.diagnostic.open_float, 'Line Diagnostics')
  keymap('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostics')
  keymap('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostics')
  -- Help
  keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
  keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  -- Jump
  keymap('n', 'gd', vim.lsp.buf.definition, 'Definition')
  keymap('n', 'gD', vim.lsp.buf.declaration, 'Declaration')
  keymap('n', '<leader>lds', require 'telescope.builtin'.lsp_document_symbols, 'Document Symbols')
  keymap('n', '<leader>li', vim.lsp.buf.implementation, 'Implementation')
  keymap('n', '<leader>lre', vim.lsp.buf.references, 'References')
  -- Workspace Folders
  keymap('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Workspace Folders Add')
  keymap('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Workspace Folders Remove')
  keymap('n', '<leader>lws', require 'telescope.builtin'.lsp_dynamic_workspace_symbols, 'Workspace Folders Symbols')
  keymap('n', '<leader>lwl',
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    'Workspace Folders List ')

  local status, whichkey = pcall(require, 'which-key')
  if status then
    whichkey.register({
      l = {
        name = 'LSP',
        w = 'Workspace'
      },
    }, { prefix = '<leader>' })
  end
end

return M
