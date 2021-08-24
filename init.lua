-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'folke/tokyonight.nvim' -- Theme inspired by Atom
  use {'shadmansaleh/lualine.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'folke/which-key.nvim'
  use 'ahmedkhalf/project.nvim'
  use 'akinsho/nvim-toggleterm.lua'
  use 'terrortylor/nvim-comment'
  use 'camspiers/snap'
end)

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
opt.showmode = true
opt.sidescrolloff = 8
--Decrease update time
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.spell = false
opt.spelllang = "en"
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

vim.g.tokyonight_style = "night"
vim.cmd [[colorscheme tokyonight]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

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

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'jk', '<ESC>:noh<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<ESC>:m .+1<CR>==gi', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<ESC>:m .-2<CR>==gi', {silent = true, noremap = true})
-- vim.api.nvim_set_keymap('i', '?', '?<c-g>u', {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true, noremap = true})

vim.api.nvim_set_keymap('v', '<A-j>', ":move '>+1<CR>gv-gv", {silent = true, noremap = true})
vim.api.nvim_set_keymap('v', '<A-k>', ":move '<-2<CR>gv-gv", {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', '<C-q>', ':call QuickFixToggle()<CR>', {silent = true, noremap = true})
-- vim.api.nvim_set_keymap('i', '<A-k>', '<ESC>:m .-2<CR>==gi', {silent = true, noremap = true})

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

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

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

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
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
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
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

require('lspconfig').sumneko_lua.setup {
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

require('lspconfig').solargraph.setup {
  cmd = { data_path .. '/lspinstall/ruby/solargraph/bin/solargraph', 'stdio'},
  filetypes = { 'ruby', 'rakefile' },
  root_dir = require'lspconfig.util'.root_pattern('.'),
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

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  autopairs = {enable = true},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.jumpable(1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_lsp_diagnostics = 0
vim.g.nvim_tree_auto_close = true
vim.g.nvim_tree_auto_ignore_ft = {"startify", "dashboard"}
vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0
}
vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "➜",
        untracked = "",
        ignored = "◌"
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = ""
    }
}

require('lualine').setup()
require('project_nvim').setup{}
require('which-key').setup{
plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false, -- adds help for operators like d, y, ...
                motions = false, -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true -- bindings for prefixed with g
            }
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+" -- symbol prepended to a group
        },
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
            padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
        },
        layout = {
            height = {min = 4, max = 25}, -- min and max height of the columns
            width = {min = 20, max = 50}, -- min and max width of the columns
            spacing = 3 -- spacing between columns
        },
        hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
        show_help = true -- show help message on the command line when the popup is visible
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false -- use `nowait` when creating keymaps
    }

    -- explorer
    vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

    -- dashboard
    vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

    -- Comments
    vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

    -- Buffers
    vim.api.nvim_set_keymap("n", "<leader>b", ":SnapBuffers<CR>", {noremap = true, silent = true})

    local mappings = {
        ["/"] = "Comment",
        ["e"] = "Explorer",
        ["b"] = "Buffers",
        d = {
            name = 'Diagnostics',
            ga = {"<cmd>lua vim.lsp.diagnostic.get_all()<cr>", "Get All"},
            gn = {"<cmd>lua vim.lsp.diagnostic.get_next()<cr>", "Get Next"},
            gp = {"<cmd>lua vim.lsp.diagnostic.get_prev()<cr>", "Get Previous"},
            gld = {"<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<cr>", "Get Line Diagnostics"},
            gtn = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Go to Next"},
            gtp = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Go to Previous"},
            sld = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Show Line Diagnostics"},
        },
        f = {
            name = "+Find",
            -- b = {"<cmd>Telescope buffers<cr>", "Open buffers"},
            -- c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
            -- ds = {"<cmd>Telescope lsp_document_symbols<cr>", "Colorscheme"},
            e = {"<cmd>Telescope file_browser<cr>", "File Browser"},
            x = {"<cmd> Telescope find_files<CR>", "Find Files"},
            b = {"<cmd>lua SnapBuffers()<CR>", "Find Files"},
            f = {"<cmd>lua SnapFiles()<CR>", "Find Files"},
            w = {"<cmd>lua SnapGrep()<CR>", "Find Word"},
            g = {"<cmd>lua SnapGit()<CR>", "Find Git"},
            sw = {"<cmd>lua SnapGrepSelectedWord()<CR>", "Find Selected Word"},
            of = {"<cmd>lua SnapOldFiles()<CR>", "Find Old Files"},
            -- i = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Current Buffer"},
            -- km = {"<cmd>Telescope keymaps<cr>", "Find Keymaps"},
            -- m = {"<cmd>Telescope marks<cr>", "Marks"},
            -- p = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
            -- of = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
            -- ts = {"<cmd>Telescope treesitter<cr>", "Treesitter"},
            -- td = {"<cmd>TodoTelescope<cr>", "Find TODO's"},
            -- vo = {"<cmd>Telescope vim_options<cr>", "Find Vim Options"},
            -- gs = {"<cmd>Telescope grep_string<cr>", "Grep String"},
            -- ws = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workplace Symbols"},
        },
        g = {
            name = "+Git",
            nh = {"<cmd>lua require'gitsigns'.next_hunk()<cr>", "Next Hunk"},
            ph = {"<cmd>lua require'gitsigns'.prev_hunk()<cr>", "Previous Hunk"},
            sh = {"<cmd>lua require'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
            ush = {"<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>", "Unstage Hunk"},
            rh = {"<cmd>lua require'gitsigns'.reset_hunk()<cr>", "Reset Hunk"},
            rb = {"<cmd>lua require'gitsigns'.reset_buffer()<cr>", "Reset Buffer"},
            pvh = {"<cmd>lua require'gitsigns'.preview_hunk()<cr>", "Preview Hunk"},
            b = {"<cmd>lua require'gitsigns'.blame_line()<cr>", "Blame Line"},
        },
        l = {
            name = "+LSP",
            a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
            i = {"<cmd>LspInfo<cr>", "Info"},
            f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "LSP Finder"},
            -- l = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
            -- p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
            r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
            t = {"<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition"},
        },
    }

    local wk = require("which-key")
    wk.register(mappings, opts)

require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 20 or function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved',
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}

require('nvim_comment').setup({
  comment_empty = false,
  hook = function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
  end
})

-- Snap
local snap = require "snap"
local fzf = snap.get "consumer.fzf"
local limit = snap.get "consumer.limit"
local producer_file = snap.get"producer.ripgrep.file".args {
    '--hidden', "--iglob", "!vendor/* !node_modules/* !target/* !git/*"
}
local producer_vimgrep = snap.get "producer.ripgrep.vimgrep"
local producer_buffer = snap.get "producer.vim.buffer"
local producer_oldfile = snap.get "producer.vim.oldfile"
local producer_git = snap.get "consumer.fzf"(snap.get "producer.git.file")
local select_vimgrep = snap.get "select.vimgrep"
local preview_file = snap.get "preview.file"
local preview_vimgrep = snap.get "preview.vimgrep"

function SnapFiles()
    snap.run({
        prompt = "  Files  ",
        producer = fzf(producer_file),
        select = select_vimgrep.select,
        multiselect = select_vimgrep.multiselect,
        views = {preview_file}
    })
end

function SnapGrep()
    snap.run({
        prompt = "  Grep  ",
        producer = limit(10000, producer_vimgrep),
        select = select_vimgrep.select,
        multiselect = select_vimgrep.multiselect,
        views = {preview_vimgrep}
    })
end

function SnapGrepSelectedWord()
    snap.run({
        prompt = "  Grep  ",
        producer = limit(10000, producer_vimgrep),
        select = select_vimgrep.select,
        multiselect = select_vimgrep.multiselect,
        views = {preview_vimgrep},
        initial_filter = vim.fn.expand("<cword>")
    })
end

function SnapGit()
    snap.run {
        prompt = "  Git  ",
        producer = producer_git,
        select = select_vimgrep.select,
        multiselect = select_vimgrep.multiselect,
        views = {snap.get "preview.file"}
    }
end

function SnapBuffers()
    snap.run({
        prompt = " ﬘ Buffers  ",
        producer = fzf(producer_buffer),
        select = select_vimgrep.select,
        multiselect = select_vimgrep.multiselect,
        views = {preview_file}
    })
end

function SnapOldFiles()
    snap.run({
        prompt = "  Oldfiles  ",
        producer = fzf(producer_oldfile),
        select = select_vimgrep.select,
        multiselect = select_vimgrep.multiselect,
        views = {preview_file}
    })
end
