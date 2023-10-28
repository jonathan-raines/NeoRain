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

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable completion triggered by <c-x><c-o>
    if client.server_capabilities.completionProvider then
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    if client.server_capabilities.definitionProvider then
      vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- Enable inlay hints
    if client.server_capabilities.inlayHintProvider then
      -- vim.lsp.inlay_hint(ev.buf, true)
      keymap('n', '<leader>lh', function() vim.lsp.inlay_hint(ev.buf, nil) end, 'Inlay Hints')
    end

    -- Format on Save
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
    keymap('n', '<space>lf', function()
      vim.lsp.buf.format { async = true }
    end, 'Format')

    -- Diagnostics
    keymap('n', '<leader>ll', vim.diagnostic.setloclist, 'Set Local List')
    keymap('n', '<leader>ld', vim.diagnostic.open_float, 'Line Diagnostics')
    keymap('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostics')
    keymap('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostics')

    -- Help
    keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
    keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
    keymap('n', '<space>lD', vim.lsp.buf.type_definition, 'Type Definition')
    keymap('n', '<space>li', vim.cmd.LspInfo, 'Info')
    keymap('n', '<leader>lp', '<cmd>lua PeekDefinition()<CR>', 'Peek Definition')

    -- Jump
    keymap('n', 'gd', vim.lsp.buf.definition, 'Definition')
    keymap('n', 'gD', vim.lsp.buf.declaration, 'Declaration')
    keymap('n', 'gi', vim.lsp.buf.implementation, 'Implementation')
    keymap('n', 'gr', vim.lsp.buf.references, 'References')
    keymap('n', 'gs', vim.lsp.buf.document_symbol, 'Document Symbols')

    local fzf = require('fzf-lua')
    keymap('n', '<leader>ls', fzf.lsp_document_symbols, 'Document Symbols')
    keymap('n', '<leader>lS', fzf.lsp_workspace_symbols, 'Workspace Symbols')

    -- Workspace Folders
    keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
    keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
    keymap('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'List Workspace Folders')

    local function preview_location_callback(_, result)
      if result == nil or vim.tbl_isempty(result) then
        return nil
      end
      vim.lsp.util.preview_location(result[1])
    end

    function PeekDefinition()
      local params = vim.lsp.util.make_position_params()
      return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
    end
  end,
})
