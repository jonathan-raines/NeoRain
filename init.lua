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
  use 'wbthomason/packer.nvim'

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup {
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          layout_config = {
            height = 0.9,
            preview_width = 80,
            width = 0.9,
          },
          mappings = {
            i = {},
          },
          pickers = {
            find_files = {
              hidden = true,
            },
          }
        },
      }
      --Add leader shortcuts
      -- vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
    end,
    event = "UIEnter",
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use {
    'camspiers/snap',
    config = function ()
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
      local select_file = snap.get "select.file"
      local select_vimgrep = snap.get "select.vimgrep"
      local preview_file = snap.get "preview.file"
      local preview_vimgrep = snap.get "preview.vimgrep"

      function SnapFiles()
        snap.run({
          prompt = "  Files  ",
          producer = fzf(producer_file),
          select = select_file.select,
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
          select = select_file.select,
          multiselect = select_file.multiselect,
          views = {preview_file}
        }
      end

      function SnapBuffers()
        snap.run({
          prompt = " ﬘ Buffers  ",
          producer = fzf(producer_buffer),
          select = select_file.select,
          multiselect = select_file.multiselect,
          views = {preview_file}
        })
      end

      function SnapOldFiles()
        snap.run({
          prompt = "  Oldfiles  ",
          producer = fzf(producer_oldfile),
          select = select_file.select,
          multiselect = select_file.multiselect,
          views = {preview_file}
        })
      end
      vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua SnapBuffers()<CR>", {noremap = true, silent = true})
    end,
    after = 'which-key.nvim'
  }

  -- UI
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.cmd [[colorscheme tokyonight]]
    end,
    event = "UIEnter"
  }
  use {
    'shadmansaleh/lualine.nvim',
    config = function()
      require('lualine').setup()
    end,
    event = "UIEnter",
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '_' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' },
        },
      }
    end,
    event = 'BufReadPre',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup({
        comment_empty = false,
        hook = function()
          if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
            require("ts_context_commentstring.internal").update_commentstring()
          end
        end
      })

      vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
    end,
    event = "BufReadPre"
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      local border = { "─", "│", "─", "│", "┌", "┐", "┘", "└" } -- { "", "", "", " ", "", "", "", " " }

      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        ignore_installed = {'haskell'},
        autopairs = { enable = true },
        autotag = {enable = true},
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        indent = {
          enable = true,
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        textobjects = {
          lsp_interop = {
            enable = true,
            border = border,
            peek_definition_code = {
              ['gp'] = '@function.outer'
            }
          },
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['ai'] = '@conditional.outer',
              ['ii'] = '@conditional.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
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
          swap = {
            enable = true,
            swap_next = {
              ['glc'] = '@class.outer',
              ['glf'] = '@function.outer',
              ['glp'] = '@parameter.inner',
            },
           swap_previous = {
              ['ghc'] = "@class.outer",
              ['ghf'] = "@function.outer",
              ['ghp'] = "@parameter.inner",
            },
          },
        },
      }
    end,
    event = "BufRead"
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
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
    end,
    event = "InsertEnter"
  }
  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    ft = { 'vue', 'html', 'tsx', 'svelte', 'php' }
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = { 'js', 'css', 'html', 'vue', 'lua' },
    after = 'nvim-treesitter'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter'
  }
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function ()
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.formatting.eslint_d.with({
          condition = function(utils)
              return utils.root_has_file(".eslintrc.js")
          end,
        }),
        null_ls.builtins.diagnostics.eslint_d,
      }
      require("null-ls").config({
          sources = sources
      })

      require("lspconfig")["null-ls"].setup({
          on_attach = on_attach,
      })
    end,
    event = 'BufRead',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' } }
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
    ft = { 'js', 'vue' }
  }

  -- Auto Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'onsails/lspkind-nvim'

  use {
    'folke/which-key.nvim',
    config = function ()
      require('which-key').setup{
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          presets = {
              operators = false, -- adds help for operators like d, y, ...
              motions = false, -- adds help for motions
              text_objects = true, -- help for text objects triggered after entering an operator
              windows = false, -- default bindings on <c-w>
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
        hidden = {"<silent>", "<cmd>", "<cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
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
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<leader><space>', '<C-^>', {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<A-i>', ':ToggleTerm<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('t', '<A-i>', ':ToggleTerm<CR>', {noremap = true, silent = true})

      -- Buffers
      vim.api.nvim_set_keymap("n", "<leader>c", ":bdelete<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>C", "<cmd>BufOnly<CR>", {noremap = true, silent = true})

      vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>q", ":q!<CR>", {noremap = true, silent = true})

      local mappings = {
        ["/"] = "Comment",
        ['<space>'] = 'Switch to Last Buffer',
        ["e"] = "Explorer",
        ["b"] = "Buffers",
        ["w"] = "Save",
        ["c"] = "Close Buffer",
        ["C"] = "Close All Except Current Buffer",
        ["q"] = "Quit",
        d = {
          name = 'Diagnostics',
          ga = {"<cmd>lua vim.lsp.diagnostic.get_all()<cr>", "Get All"},
          gn = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Get Next"},
          gp = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Get Previous"},
          ld = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Show Line Diagnostics"},
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
          r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
          t = {"<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition"},
        },
      }

      local wk = require("which-key")
      wk.register(mappings, opts)
    end,
    event = "VimEnter"
  }
  use {
    'ahmedkhalf/project.nvim',
    config = function ()
      require('project_nvim').setup{
        ignore_lsp = { 'solargraph' },
        show_hidden = true,
      }
    end,
    event = 'BufEnter'
  }
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function ()
      require("toggleterm").setup{
        -- size can be a number or function which is passed the current terminal
        size = 20 or function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'horizontal',
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

      function _G.set_terminal_keymaps()
        local opts = {noremap = true}
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal  = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
      local term = Terminal:new({ hidden = true, direction = 'horizontal' })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      function _normterm_toggle()
        term:toggle()
      end

      vim.api.nvim_set_keymap("n", "<A-l>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("t", "<A-l>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

      vim.api.nvim_set_keymap("n", "<A-i>", "<cmd>lua _normterm_toggle()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("t", "<A-i>", "<cmd>lua _normterm_toggle()<CR>", {noremap = true, silent = true})
    end,
    event = 'VimEnter'
  }
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

vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_lsp_diagnostics = 0
vim.g.nvim_tree_auto_close = 1
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
