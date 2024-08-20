vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Settings',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
    local methods = vim.lsp.protocol.Methods

    -- Keymaps
    local function keymap(lhs, rhs, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, lhs, rhs, { buffer = 0, desc = desc })
    end

    -- Diagnostics
    keymap('<leader>ll', vim.diagnostic.setloclist, 'Set Local List')

    -- Definition
    keymap('gd', function()
      require('fzf-lua').lsp_definitions { jump_to_single_result = true }
    end, 'Go to definition')

    -- Formatting
    keymap('<leader>lf', vim.lsp.buf.format, 'Format')

    -- References
    keymap('grr', '<cmd>FzfLua lsp_references<cr>', 'vim.lsp.buf.references()')

    -- Symbols
    keymap('<leader>fs', function()
      require('fzf-lua').lsp_document_symbols {}
    end, 'Document symbols')

    keymap('<leader>fS', function()
      require('fzf-lua').lsp_live_workspace_symbols { no_header_i = true }
    end, 'Workspace symbols')

    -- Declaration
    if client.supports_method(methods.textDocument_declaration) then
      keymap('gD', function()
        require('fzf-lua').lsp_declarations { jump_to_single_result = true }
      end, 'Go to declaration')
    end

    -- Inlay Hints
    if client.supports_method(methods.textDocument_inlayHint) then
      keymap('<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }))
      end, 'Inlay Hints')
    end

    -- Signature Help
    if client.supports_method(methods.textDocument_signatureHelp) then
      keymap('<C-k>', function()
        vim.lsp.buf.signature_help()
      end, 'Signature help', 'i')
    end

    -- Document Highlighting
    -- if client.supports_method(methods.textDocument_documentHighlight) then
    --   local under_cursor_highlights_group =
    --       vim.api.nvim_create_augroup('mariasolos/cursor_highlights', { clear = false })
    --   vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave', 'BufEnter' }, {
    --     group = under_cursor_highlights_group,
    --     desc = 'Highlight references under the cursor',
    --     buffer = 0,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
    --     group = under_cursor_highlights_group,
    --     desc = 'Clear highlight references',
    --     buffer = 0,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end

    -- Formatting
    if client.name ~= 'tsserver' then
      client.server_capabilities.documentFormattingProvider = true
    end

    -- Format on save
    if client.supports_method(methods.textDocument_formatting) then
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
  end,
})
