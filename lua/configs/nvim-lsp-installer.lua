---@diagnostic disable: undefined-global
local lsp_installer = require 'nvim-lsp-installer'
local map = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

local mappings = {
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc'),
  map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts),
  map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts),
  map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts),
  map(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts),
  map(bufnr, 'n', 'gR', '<cmd>Telescope lsp_references theme=get_ivy<CR>', opts),
  map(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts),
  map(bufnr, 'n', 'gp', '<cmd>Telescope lsp_definitions jump_type=never theme=get_cursor<CR>', opts),
  map(bufnr, 'n', 'ge', "<cmd>lua vim.diagnostic.open_float(0, {scope = 'line', border = 'rounded'})<CR>", opts),
  map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts),
  map(bufnr, 'v', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts),
  map(bufnr, 'n', 'ga', '<cmd>Telescope lsp_code_actions theme=get_cursor<CR>', opts),
  map(bufnr, 'v', 'ga', '<cmd>Telescope lsp_code_actions theme=get_cursor<CR><ESC>', opts),
  map(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts),
  map(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts),
}

function _G_custom_on_attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup end

            ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
              augroup lsp_document_codelens
                au! * <buffer>
                autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
              augroup end
            ]]
  end

  require('which-key').register({
    g = {
      ['a'] = 'Code Action',
      ['b'] = 'Comment Block',
      ['c'] = 'Comment Line',
      ['d'] = 'Definition',
      ['D'] = 'Declaration',
      ['e'] = 'Line Diagnostics',
      ['i'] = 'Implementation',
      ['l'] = 'Lazygit',
      ['p'] = 'Peek Definition',
      ['r'] = 'Rename',
      ['R'] = 'References',
      ['x'] = 'Open File Under cursor',
    },
  }, opts)

  return mappings
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

lsp_installer.on_server_ready(function(server)
  local opts2 = { on_attach = _G_custom_on_attach, capabilities = capabilities }

  if server.name == 'tsserver' then
    opts2 = {
      -- Only needed for inlayHints. Merge this table with your settings or copy
      -- it from the source if you want to add your own init_options.
      init_options = require('nvim-lsp-ts-utils').init_options,
      --
      on_attach = function(client, bufnr)
        -- disable tsserver formatting if you plan on formatting via null-ls
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require 'nvim-lsp-ts-utils'

        -- defaults
        ts_utils.setup {
          debug = false,
          disable_commands = false,
          enable_import_on_completion = false,

          -- import all
          import_all_timeout = 5000, -- ms
          -- lower numbers indicate higher priority
          import_all_priorities = {
            same_file = 1, -- add to existing import statement
            local_files = 2, -- git files or files with relative path markers
            buffer_content = 3, -- loaded buffer content
            buffers = 4, -- loaded buffer names
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,

          -- eslint
          eslint_enable_code_actions = true,
          eslint_enable_disable_comments = true,
          eslint_bin = 'eslint',
          eslint_enable_diagnostics = false,
          eslint_opts = {},

          -- formatting
          enable_formatting = false,
          formatter = 'prettier',
          formatter_opts = {},

          -- update imports on file move
          update_imports_on_move = false,
          require_confirmation_on_move = false,
          watch_dir = nil,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},

          -- inlay hints
          auto_inlay_hints = true,
          inlay_hints_highlight = 'Comment',
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts3 = { silent = true }
        table.insert(mappings, {
          map(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts3),
          map(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts3),
          map(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts3),
        })
      end,
    }
  end

  server:setup(opts2)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

require('lspconfig').solargraph.setup {
  on_attach = _G_custom_on_attach,
  capabilities = capabilities,
}
