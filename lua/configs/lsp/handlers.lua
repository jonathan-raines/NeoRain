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

M.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function lsp_document_codelens(client)
  if client.resolved_capabilities.code_lens then
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
  if client.resolved_capabilities.document_highlight then
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

local function whichkey_document_keymaps()
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    return
  end

  wk.register {
    g = {
      a = 'Code Action',
      d = 'Definition',
      D = 'Declaration',
      e = 'Line Diagnostics',
      F = 'Formatting',
      i = 'Implementation',
      q = 'Set Loclist',
      rn = 'Rename',
      rr = 'References',
    },
    ['['] = {
      d = 'Previous Diagnostic',
    },
    [']'] = {
      d = 'Next Diagnostic',
    },
  }
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', 'grr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  keymap(bufnr, 'n', 'gq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  keymap(bufnr, 'n', 'gwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  keymap(bufnr, 'n', 'gwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  keymap(bufnr, 'n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  keymap(bufnr, 'n', 'gF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  whichkey_document_keymaps()
end

M.on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Autoformat buffer on save',
      group = 'FormatOnSave',
      pattern = '<buffer>',
      callback = function()
        vim.lsp.buf.formatting_sync()
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
