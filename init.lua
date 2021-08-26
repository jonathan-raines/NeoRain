require 'plugins'

local vim = vim
local opt = vim.opt

--Enable break indent
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.colorcolumn = "100"
-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'
--Incremental live completion (note: this is now a default on master)
opt.conceallevel = 0
opt.cursorline = true
opt.expandtab = true
opt.foldtext = 'CustomFold()'
opt.foldlevelstart = 5
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
--Do not save when switching buffers (note: this is now a default on master)
opt.hidden = true
--Set highlight on search
opt.hlsearch = true
--Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 4 -- default is 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append("c")
opt.showmode = true
opt.sidescrolloff = 8
--Decrease update time
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.spell = false
opt.spelllang = "en"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
--Set colorscheme (order is important here)
opt.termguicolors = true
opt.timeoutlen = 100
opt.title = true
opt.undodir = vim.fn.stdpath('cache') .. '/undo'
opt.undofile = true
opt.updatetime = 250
opt.wrap = false
opt.writebackup = false


--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keeping it centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', {silent = true, noremap = true})

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', {silent = true, noremap = true})

-- Jumplist mutations
vim.cmd('nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"')
vim.cmd('nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"')

-- Escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'jk', ':noh<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('v', 'jk', '<ESC>', {silent = true, noremap = true})

-- Move Lines Around
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<ESC>:m .+1<CR>==gi', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<ESC>:m .-2<CR>==gi', {silent = true, noremap = true})
vim.api.nvim_set_keymap('v', '<A-j>', ":move '>+1<CR>gv-gv", {silent = true, noremap = true})
vim.api.nvim_set_keymap('v', '<A-k>', ":move '<-2<CR>gv-gv", {silent = true, noremap = true})

-- Redo
vim.api.nvim_set_keymap('n', 'U', '<C-R>', {silent = true, noremap = true})

-- Move Windows Around
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true, noremap = true})

-- Jump to start/end of line
vim.api.nvim_set_keymap('n', 'H', '^', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'L', '$', {silent = true, noremap = true})

-- Resize windows
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true, noremap = true})

-- Indent
vim.api.nvim_set_keymap('v', '<', '<gv', {silent = true, noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<', '<<', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '>', '>>', {silent = true, noremap = true})

-- Quickfix
vim.api.nvim_set_keymap('n', '<C-q>', ':call QuickFixToggle()<CR>', {silent = true, noremap = true})

-- Y behaves like C/D
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- QuickFixToggle
vim.cmd(
[[function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
    else
    cclose
    endif
endfunction]]
)

-- Custom Fold
vim.cmd(
[[function! CustomFold()
    return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
endfunction]]
)

-- Folding
vim.cmd('set foldnestmax=6')
vim.cmd('set foldlevelstart=20')

-- Diagnostics
vim.fn.sign_define("LspDiagnosticsSignError", {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})

require("cmp_nvim_lsp").setup()

-- luasnip setup
local luasnip = require 'luasnip'

-- lspkind setup
local lspkind = require 'lspkind'

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- nvim-cmp setup
local cmp = require 'cmp'

cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = lspkind.presets.default[vim_item.kind]
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-n>'), 'n')
      elseif luasnip.jumpable(1) then
        vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-p>'), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}


-- use({
--     'hrsh7th/nvim-cmp',
--     config = function()
--         -- my configuration
--     end,
--     requires = {
--         -- not lazy-loading, so read after/plugin
--         { 'hrsh7th/cmp-path' },
--         -- TODO: cmp-spell
--         {
--             'hrsh7th/cmp-nvim-lua',
--             ft = 'lua',
--             -- this is after/plugin content
--             config = function()
--                 require('cmp').register_source('nvim_lua', require('cmp_nvim_lua').new())
--             end,
--         },
--         {
--             'hrsh7th/cmp-nvim-lsp',
--             ft = my_fts,
--             config = function()
--                 require('cmp_nvim_lsp').setup()
--             end,
--         },
--     },
-- })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
vim.cmd [[ autocmd BufWinEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufNewFile * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufWinEnter NvimTree set colorcolumn=0 nocursorcolumn ]]
vim.cmd [[ command BufOnly silent! execute "%bd|e#|bd#" ]]
-- vim.cmd [[ autocmd ]]

-- Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Enable the following language servers
local servers = { 'clangd', 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Example custom server
local data_path = vim.fn.stdpath("data")
local sumneko_binary = data_path .. '/lspinstall/lua/sumneko-lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', data_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

nvim_lsp.solargraph.setup {
  cmd = { 'solargraph', 'stdio' },
  filetypes = { 'ruby', 'rakefile' },
  root_dir = require'lspconfig.util'.root_pattern('.'),
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    solargraph = {
      formatting = true,
    }
  },
}

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

nvim_lsp.tsserver.setup {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  root_dir = require'lspconfig.util'.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

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
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = false,
      eslint_show_rule_id = false,

      -- formatting
      enable_formatting = false,
      formatter = "eslint_d",
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
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
  end
}

nvim_lsp.vuels.setup {
  cmd = { data_path .. "/lspinstall/vue/node_modules/.bin/vls", "--stdio" },
  on_attach = on_attach,
  root_dir = require("lspconfig").util.root_pattern(".git", "vue.config.js", "package.json", "yarn.lock"),
}
