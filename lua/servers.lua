local lsp_installer = require 'nvim-lsp-installer'
local map = vim.api.nvim_buf_set_keymap

function _G.rename()
  local rename = 'textDocument/rename'
  local currName = vim.fn.expand '<cword>'
  local tshl = require('nvim-treesitter-playground.hl-info').get_treesitter_hl()
  if tshl and #tshl > 0 then
    local ind = tshl[#tshl]:match '^.*()%*%*.*%*%*'
    tshl = tshl[#tshl]:sub(ind + 2, -3)
  end

  local win = require('plenary.popup').create(currName, {
    title = 'New Name',
    style = 'minimal',
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    relative = 'cursor',
    borderhighlight = 'FloatBorder',
    titlehighlight = 'Title',
    highlight = tshl,
    focusable = true,
    width = 25,
    height = 1,
    line = 'cursor+2',
    col = 'cursor-1',
  })

  local map_opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, 'i', '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
  vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', "<cmd>stopinsert | lua _rename('" .. currName .. "')<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', "<cmd>stopinsert | lua _rename('" .. currName .. "')<CR>", map_opts)

  local function handler(err, result, ctx, config)
    if err then
      vim.notify(("Error running lsp query '%s': %s"):format(rename, err), vim.log.levels.ERROR)
    end
    local new
    if result and result.changes then
      local msg = ''
      for f, c in pairs(result.changes) do
        new = c[1].newText
        msg = msg .. ('%d changes -> %s'):format(#c, f:gsub('file://', ''):gsub(vim.fn.getcwd(), '.')) .. '\n'
        msg = msg:sub(1, #msg - 1)
        vim.notify(msg, vim.log.levels.INFO, { title = ('Rename: %s -> %s'):format(currName, new) })
      end
    end
    vim.lsp.handlers[rename](err, result, ctx, config)
  end

  function _G._rename(curr)
    local newName = vim.trim(vim.fn.getline '.')
    vim.api.nvim_win_close(win, true)
    if #newName > 0 and newName ~= curr then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName
      vim.lsp.buf_request(0, rename, params, handler)
    end
  end
end

local custom_on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'n', 'gp', "<cmd>lua require'configs.peek'.Peek('definition')<CR>", opts)
  map(bufnr, 'n', 'ge', "<cmd>lua vim.diagnostic.open_float(0, {scope = 'line', border = 'single'})<CR>", opts)
  -- map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map(bufnr, 'n', 'gr', '<cmd>lua _G.rename()<CR>', opts)
  map(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map(bufnr, 'v', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

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

  local wk = require 'which-key'
  wk.register({
    g = {
      ['a'] = 'Code Action',
      ['b'] = 'Comment Block',
      ['c'] = 'Comment Line',
      ['d'] = 'Definition',
      ['D'] = 'Declaration',
      ['e'] = 'Line Diagnostics',
      ['p'] = 'Peek Definition',
      ['r'] = 'Rename',
      ['R'] = 'References',
      ['x'] = 'Open File Under cursor',
    },
  }, opts)
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
  local opts2 = { on_attach = custom_on_attach, capabilities = capabilities }

  if server.name == 'sumneko_lua' then
    opts2['settings'] = {
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    }
  end

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

          -- eslint
          eslint_enable_code_actions = true,
          eslint_enable_disable_comments = true,
          eslint_bin = 'eslint_d',
          eslint_config_fallback = nil,
          eslint_enable_diagnostics = false,
          eslint_show_rule_id = false,

          -- formatting
          enable_formatting = false,
          formatter = 'eslint_d',
          formatter_config_fallback = nil,

          -- update imports on file move
          update_imports_on_move = false,
          require_confirmation_on_move = false,
          watch_dir = nil,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        -- local opts = { silent = true }
        -- map(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
        -- map(bufnr, 'n', 'qq', ':TSLspFixCurrent<CR>', opts)
        -- map(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
        -- map(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
      end,
    }

    if server.name == 'vuels' then
      opts2['init_options'] = {
        config = {
          vetur = {
            completion = {
              autoImport = true,
              tagCasing = 'kebab',
              useScaffoldSnippets = true,
            },
            useWorkspaceDependencies = true,
            validation = {
              script = true,
              style = true,
              template = true,
            },
          },
        },
      }
    end

    if server.name == 'yamlls' then
      opts2['settings'] = {
        yaml = {
          hover = true,
          completion = true,
          validate = true,
          schemaStore = {
            enable = true,
            url = 'https://www.schemastore.org/api/json/catalog.json',
          },
          schemas = {
            kubernetes = {
              'daemon.{yml,yaml}',
              'manager.{yml,yaml}',
              'restapi.{yml,yaml}',
              'role.{yml,yaml}',
              'role_binding.{yml,yaml}',
              '*onfigma*.{yml,yaml}',
              '*ngres*.{yml,yaml}',
              '*ecre*.{yml,yaml}',
              '*eployment*.{yml,yaml}',
              '*ervic*.{yml,yaml}',
              'kubectl-edit*.yaml',
            },
          },
        },
      }
    end
  end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts2)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

require('lspconfig').solargraph.setup {
  cmd = { 'solargraph', 'stdio' },
  filetypes = { 'ruby', 'rakefile' },
  root_dir = require('lspconfig.util').root_pattern '.',
  on_attach = custom_on_attach,
  capabilities = capabilities,
  settings = {
    solargraph = {
      formatting = true,
      rename = true,
    },
  },
}
