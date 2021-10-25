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

  -- use { 'rmagatti/auto-session', event = 'VimEnter' }

  use { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' }, { 'kyazdani42/nvim-web-devicons' } }

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
    'folke/tokyonight.nvim',
    config = function()
      -- Example config in Lua
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }

      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      vim.g.tokyonight_colors = { hint = 'orange', error = '#ff0000' }
      vim.cmd [[colorscheme tokyonight]]
    end,
    after = 'lualine.nvim',
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'configs.lualine'
    end,
    event = 'UIEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'configs.gitsigns'
    end,
    event = 'BufRead',
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
    event = 'BufEnter',
    requires = {},
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
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'configs.nvim-tree'
    end,
    event = 'VimEnter',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require 'servers'
    end,
    after = 'nvim-lspconfig',
  }

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
    event = 'BufRead',
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
      require 'configs.harpoon'
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
    ft = { 'http' },
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
      require 'configs.mini'
    end,
    event = 'BufRead',
  }

  use {
    'romgrk/barbar.nvim',
    config = function()
      require 'configs.barbar'
    end,
    event = 'BufEnter',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
end)
