---@diagnostic disable: undefined-global
local lsp_installer = require 'nvim-lsp-installer'
local map = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

_G_mappings = {
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

---@diagnostic disable: unused-local
function _G_custom_on_attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   vim.cmd [[
  --             augroup lsp_document_highlight
  --               autocmd! * <buffer>
  --               autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --               autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --             augroup end
  --
  --           ]]
  -- end

  -- if client.resolved_capabilities.code_lens then
  --   vim.cmd [[
  --             augroup lsp_document_codelens
  --               au! * <buffer>
  --               autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
  --             augroup end
  --           ]]
  -- end

  require('which-key').register({
    g = {
      ['a'] = 'Code Action',
      ['b'] = 'Comment Block',
      ['bc'] = 'Comment Block',
      ['c'] = 'Comment Line',
      ['cc'] = 'Comment Line',
      ['d'] = 'Definition',
      ['D'] = 'Declaration',
      ['e'] = 'Line Diagnostics',
      ['i'] = 'Implementation',
      ['p'] = 'Peek Definition',
      ['r'] = 'Rename',
      ['R'] = 'References',
      ['x'] = 'Open File Under cursor',
    },
  }, opts)

  return _G_mappings
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
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
      init_options = {
        hostInfo = 'neovim',
      },
      root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
      capabilities = capabilities,
      ---@diagnostic disable-next-line: unused-local
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
          import_all_priorities = {
            buffers = 4, -- loaded buffer names
            buffer_content = 3, -- loaded buffer content
            local_files = 2, -- git files or files with relative path markers
            same_file = 1, -- add to existing import statement
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},

          -- inlay hints
          auto_inlay_hints = true,
          inlay_hints_highlight = 'Comment',

          -- update imports on file move
          update_imports_on_move = false,
          require_confirmation_on_move = false,
          watch_dir = nil,
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)
      end,
    }
  end

  server:setup(opts2)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

require('lspconfig').solargraph.setup {
  filetypes = { 'ruby', 'rake' },
  on_attach = _G_custom_on_attach,
  capabilities = capabilities,
}
