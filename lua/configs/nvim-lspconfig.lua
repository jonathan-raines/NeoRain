---@diagnostic disable: undefined-global
vim.fn.sign_define('LspDiagnosticsSignError', { texthl = 'LspDiagnosticsSignError', text = '', numhl = 'LspDiagnosticsSignError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { texthl = 'LspDiagnosticsSignWarning', text = '', numhl = 'LspDiagnosticsSignWarning' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { texthl = 'LspDiagnosticsSignInformation', text = '', numhl = 'LspDiagnosticsSignInformation' })
vim.fn.sign_define('LspDiagnosticsSignHint', { texthl = 'LspDiagnosticsSignHint', text = '', numhl = 'LspDiagnosticsSignHint' })

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = '',
    spacing = 0,
  },
  signs = true,
  underline = true,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
  close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
})

require('which-key').register({
  l = {
    name = 'LSP',
    d = { ':Telescope lsp_document_diagnostics<CR>', 'Document Diagnostics' },
    f = { ':lua vim.lsp.buf.formatting()<CR>', 'Format Buffer' },
    i = { ':LspInfo<CR>', 'Info' },
    j = { ':lua vim.diagnostic.goto_next()<CR>', 'Go To Next' },
    k = { ':lua vim.diagnostic.goto_prev()<CR>', 'Go To Previous' },
    l = { ":lua vim.diagnostic.open_float(0, {scope = 'line', border = 'single'})<CR>", 'Show Line Diagnostics' },
    r = { ':LspRestart<CR>', 'Restart LSP' },
    t = { ':lua vim.lsp.buf.type_definition()<CR>', 'Type Definition' },
    w = { ':Telescope lsp_workspace_diagnostics<CR>', 'Workspace Diagnostics' },
  },
}, {
  prefix = '<leader>',
})
