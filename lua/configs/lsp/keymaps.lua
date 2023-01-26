local M = {}

M.setup = function(bufnr)
  local keymap = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  -- Actions
  keymap('n', '<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  keymap('n', '<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
  keymap('n', '<leader>lf', vim.lsp.buf.format, '[F]ormat')
  -- Diagnostics
  keymap('n', '<leader>ll', vim.diagnostic.setloclist, 'Set [L]ocal List')
  keymap('n', '<leader>ldi', vim.diagnostic.open_float, 'Line [D][i]agnostics')
  keymap('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostics')
  keymap('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostics')
  -- Help
  keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
  keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  -- Jump
  keymap('n', 'gd', vim.lsp.buf.definition, 'Definition')
  keymap('n', 'gD', vim.lsp.buf.declaration, 'Declaration')
  keymap('n', '<leader>lds', require 'telescope.builtin'.lsp_document_symbols, '[D]ocument [S]ymbols')
  keymap('n', '<leader>li', vim.lsp.buf.implementation, 'Implementation')
  keymap('n', '<leader>lre', vim.lsp.buf.references, '[R][e]ferences')
  -- Workspace Folders
  keymap('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace Folders [A]dd')
  keymap('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace Folders [R]emove')
  keymap('n', '<leader>lws', require 'telescope.builtin'.lsp_dynamic_workspace_symbols, '[W]orkspace Folders [S]ymbols')
  keymap('n', '<leader>lwl',
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    '[W]orkspace Folders [L]ist ')

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
