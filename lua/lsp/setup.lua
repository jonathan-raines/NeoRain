vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}

    if client.supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0, desc = 'Implementation' })
    end

    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set('n', '<leader>lh',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }))
        end, { buffer = 0, desc = 'Inlay Hints' })
    end

    if client.name ~= 'tsserver' then
      client.server_capabilities.documentFormattingProvider = true
    end

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        desc = 'Autoformat buffer on save',
        buffer = 0,
        callback = function()
          if client.name == 'eslint' then
            vim.cmd [[ EslintFixAll ]]
          else
            vim.lsp.buf.format { async = false }
          end
        end,
      })
    end

    -- Actions
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = 0, desc = 'Rename' })
    vim.keymap.set('n', 'gq', function() vim.lsp.buf.format { async = false } end, { buffer = 0, desc = 'Format' })
    vim.keymap.set('n', '<leader>lf', function()
      vim.lsp.buf.format { async = false }
    end, { buffer = 0, desc = 'Format' })
    -- Diagnostics
    vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, { buffer = 0, desc = 'Set Local List' })
    -- Help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0, desc = 'Hover' })
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = 0, desc = 'Signature Help' })
    -- Jump
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0, desc = 'Definition' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0, desc = 'References' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0, desc = 'Declaration' })
  end,
})
