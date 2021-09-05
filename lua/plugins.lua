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

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'configs.telescope'
    end,
    command = 'Telescope',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make', event = 'VimEnter' },
    },
    after = { 'telescope-fzy-native.nvim' },
  }

  use {
    'Pocco81/Catppuccino.nvim',
    config = function()
      require('catppuccino').setup {
        colorscheme = 'dark_catppuccino',
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
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup {
        comment_empty = false,
      }

      vim.api.nvim_set_keymap('n', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
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
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'configs.nvim-tree'
    end,
    event = 'UIEnter',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end,
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
    event = 'VimEnter',
  }

  use {
    'ThePrimeagen/harpoon',
    event = 'BufRead',
    requires = { 'popup.nvim', 'plenary.nvim' },
  }

  use {
    'pwntester/octo.nvim',
    config = function()
      require('octo').setup()
    end,
    cmd = 'Octo',
  }

  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        ignore_lsp = { 'solargraph' },
      }
    end,
    event = 'BufEnter',
  }

  use {
    'simrat39/symbols-outline.nvim',
    event = 'BufRead',
  }
end)
