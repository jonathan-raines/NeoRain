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

M.capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

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

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  keymap(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Code Action' }))
  keymap(bufnr, 'n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Set Local List' }))
  keymap(bufnr, 'n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Line Diagnostics' }))
  keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Previous Diagnostics' }))
  keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Next Diagnostics' }))

  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Definition' }))
  keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Declaration' }))
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Hover' }))
  keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Implementation' }))
  keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Signature Help' }))
  keymap(bufnr, 'n', '<leader>lf', '<CMD>lua vim.lsp.buf.format { async = true }<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Format [LSP]' }))
  keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Rename' }))
  keymap(bufnr, 'n', '<leader>lR', '<cmd>lua vim.lsp.buf.references()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'References' }))

  keymap(bufnr, 'n', '<leader>li', '<CMD>LspInfo<CR>', vim.tbl_extend('keep', opts, { desc = 'LspInfo' }))
  keymap(bufnr, 'n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Next Diagnostic' }))
  keymap(bufnr, 'n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Previous Diagnostic' }))

  keymap(bufnr, 'n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Document Symbols' }))

  keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Add Workspace Folder' }))
  keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Remove Workspace Folder' }))
  keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    vim.tbl_extend('keep', opts, { desc = 'List Workspace Folders' }))
  keymap(bufnr, 'n', '<leader>lws', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
    vim.tbl_extend('keep', opts, { desc = 'Workspace Symbols' }))
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
    virtual_text = false,
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
