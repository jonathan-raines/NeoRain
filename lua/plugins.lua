local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'lewis6991/impatient.nvim',
    config = function()
      require 'impatient'
    end,
  }

  use { 'nvim-lua/plenary.nvim', { 'nvim-lua/popup.nvim' }, { 'kyazdani42/nvim-web-devicons' } }

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'configs.telescope'
    end,
    cmd = 'Telescope',
    opt = true,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make', event = 'VimEnter' },
      {
        'camgraff/telescope-tmux.nvim',
        config = function()
          require('telescope').load_extension 'tmux'
        end,
        event = 'VimEnter',
      },
    },
  }

  use {
    'Pocco81/Catppuccino.nvim',
    config = function()
      require('catppuccino').setup {
        colorscheme = 'dark_catppuccino',
        transparency = true,
        term_colors = true,
        integrations = {
          gitsigns = true,
          which_key = true,
          telescope = true,
          nvimtree = {
            enabled = true,
          },
        },
      }
      vim.cmd [[colorscheme catppuccino]]
    end,
    after = 'lualine.nvim',
  }

  use {
    'shadmansaleh/lualine.nvim',
    config = function()
      require 'configs.lualine'
    end,
    event = 'UIEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        keymaps = {
          noremap = true,

          ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
          ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '_' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' },
        },
      }
    end,
    event = 'CursorHold',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        {
          ---@param ctx Ctx
          pre_hook = function(ctx)
            return require('ts_context_commentstring.internal').calculate_commentstring()
          end,
        },
      }
    end,
    event = 'BufRead',
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'configs.treesitter'
    end,
    event = 'CursorHold',
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'configs.autopairs'
    end,
    event = 'InsertEnter',
  }

  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    ft = { 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = { 'js', 'css', 'html', 'vue', 'lua' },
    after = 'nvim-treesitter',
  }

  use {
    'rlch/github-notifications.nvim',
    config = function()
      require('github-notifications').setup {}
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end,
    event = 'BufEnter',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'configs.null-ls'
    end,
    event = 'BufReadPre',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
  }

  -- Auto Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'configs.cmp'
    end,
    requires = {
      'hrsh7th/cmp-buffer',
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
        requires = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
      },
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require 'configs.whichkey'
    end,
    event = 'CursorHold',
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require 'configs.toggleterm'
    end,
    event = 'UIEnter',
  }

  use {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup {
        global_settings = {
          save_on_toggle = false,
          save_on_change = true,
          enter_on_sendcmd = true,
        },
      }
    end,
    event = 'BufRead',
    requires = { 'popup.nvim', 'plenary.nvim' },
  }

  use {
    'pwntester/octo.nvim',
    config = function()
      require('octo').setup()
    end,
    cmd = 'Octo',
    opt = true,
  }

  use {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    opt = true,
  }

  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require('rest-nvim').setup {
        result_split_horizontal = false,
        skip_ssl_verification = false,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        jump_to_request = true,
      }
      vim.api.nvim_set_keymap('n', 'Q', "<cmd>lua require'rest-nvim'.run()<CR>", { silent = true, noremap = true })
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'akinsho/flutter-tools.nvim',
    config = function()
      require('flutter-tools').setup {}
    end,
    ft = { 'dart' },
    requires = 'nvim-lua/plenary.nvim',
  }

  use {
    'chentau/marks.nvim',
    config = function()
      require('marks').setup {
        default_mappings = true, -- whether to map keybinds or not. default true
        builtin_marks = { '.', '<', '>', '^' }, -- which builtin marks to show. default {}
        cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
        force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
        -- bookmark_0 = { -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own sign/virttext
        --   sign = '⚑',
        --   virt_text = 'hello world',
        -- },
        mappings = {},
      }
    end,
    event = 'BufRead',
  }

  use {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup {
        -- Number of lines within which surrounding is searched
        n_lines = 30,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Pattern to match function name in 'function call' surrounding
        -- By default it is a string of letters, '_' or '.'
        funname_pattern = '[%w_%.]+',

        -- Mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'sa', -- Add surrounding
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`
        },
      }
      require('mini.bufremove').setup {}
      require('mini.tabline').setup {}
    end,
  }

  -- use { 'rmagatti/auto-session', event = 'VimEnter' }
end)
