-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local keymap = function(mode, keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = desc })
    end

    local client = vim.lsp.get_client_by_id(ev.data.client_id) or {}

    -- Enable inlay hints
    if client.server_capabilities.inlayHintProvider then
      keymap('n', '<leader>lh',
        function()
          vim.lsp.inlay_hint.enable(ev.buf, not (vim.lsp.inlay_hint.is_enabled()))
        end, 'Inlay Hints')
    end

    -- Format on Save
    if client.name == 'solargraph' then
      client.server_capabilities.documentFormattingProvider = true
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

    -- Actions
    keymap('n', '<leader>la', vim.lsp.buf.code_action, 'Code Action')
    keymap('n', '<leader>lr', vim.lsp.buf.rename, 'Rename')
    keymap('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, 'Format')

    -- Diagnostics
    keymap('n', '<leader>ll', vim.diagnostic.setloclist, 'Set Local List')

    -- Help
    keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
    keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

    -- Jump
    keymap('n', 'gd', vim.lsp.buf.definition, 'Definition')
    keymap('n', 'gr', vim.lsp.buf.references, 'References')
    keymap('n', 'gs', vim.lsp.buf.document_symbol, 'Document Symbols')
    keymap('n', 'gD', vim.lsp.buf.declaration, 'Declaration')
    keymap('n', 'gi', vim.lsp.buf.implementation, 'Implementation')
  end,
})
