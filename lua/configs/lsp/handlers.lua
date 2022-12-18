local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

local cmp_ok, cmp = pcall(require 'cmp_nvim_lsp')
if cmp_ok then
  M.capabilities = cmp.default_capabilities(capabilities)
end

local function lsp_document_codelens(client)
  if client.server_capabilities.code_lens then
    vim.api.nvim_exec(
      [[
         augroup lsp_document_codelens
          autocmd! * <buffer>
          autocmd InsertLeave <buffer> lua vim.lsp.codelens.refresh()
          autocmd InsertLeave <buffer> lua vim.lsp.codelens.display()
         augroup end
       ]],
      false
    )
  end
end

local function lsp_highlight_document(client)
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local lsp_keymaps = function(bufnr)
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
  keymap('n', '<leader>ll', vim.diagnostic.setloclist, 'Set [L]ocal [L]ist')
  keymap('n', '<leader>ld', vim.diagnostic.open_float, '[L]ine [D]iagnostics')
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
end

M.on_attach = function(client, bufnr)
  if client.name ~= 'eslint' then
    local navic = require 'nvim-navic'
    navic.attach(client, bufnr)
  end

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

  lsp_keymaps(bufnr)
  lsp_document_codelens(client)
  lsp_highlight_document(client)
end

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    float = {
      border = 'rounded',
      focusable = false,
      header = '',
      prefix = '',
      source = 'always',
      style = 'minimal',
    },
    severity_sort = true,
    signs = {
      active = signs,
    },
    underline = true,
    update_in_insert = false,
    virtual_lines = {
      only_current_line = false
    },
    virtual_text = true,
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
    close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
  })
end

return M
