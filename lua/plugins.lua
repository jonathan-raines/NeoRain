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

  use {
    { 'nathom/filetype.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
  }

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/telescope'
    end,
    event = 'BufRead',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/playground' },
      {
        'camgraff/telescope-tmux.nvim',
        config = function()
          require('telescope').load_extension 'tmux'
        end,
      },
    },
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      require './configs/tokyonight'
    end,
    after = 'lualine.nvim',
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require './configs/lualine'
    end,
    event = 'UIEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require './configs/gitsigns'
    end,
    event = 'BufRead',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require './configs/comment'
    end,
    event = 'BufRead',
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require './configs/treesitter'
    end,
    event = 'BufEnter',
    requires = {
      {
        'code-biscuits/nvim-biscuits',
        config = function()
          require('nvim-biscuits').setup {}
        end,
        after = 'nvim-treesitter',
      },
      {
        'nvim-treesitter/playground',
      },
    },
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require './configs/autopairs'
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
      require './configs/nvim-tree'
    end,
    cmd = 'NvimTreeToggle',
    opt = true,
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
    event = 'BufReadPre',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require './configs/null-ls'
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
      require './configs/cmp'
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
        requires = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
      },
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require './configs/whichkey'
    end,
    event = 'UIEnter',
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require './configs/toggleterm'
    end,
    event = 'BufRead',
  }

  use {
    'ThePrimeagen/harpoon',
    config = function()
      require './configs/harpoon'
    end,
    event = 'BufEnter',
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
      require './configs/rest'
    end,
    ft = { 'http' },
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
      require './configs/marks'
    end,
    event = 'BufRead',
  }

  use {
    'echasnovski/mini.nvim',
    config = function()
      require './configs/mini'
    end,
    event = 'BufRead',
  }

  use {
    'romgrk/barbar.nvim',
    config = function()
      require './configs/barbar'
    end,
    event = 'BufRead',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- TESTING
  use {
    'TimUntersberger/neogit',
    config = function()
      require './configs/neogit'
    end,
    cmd = 'Neogit',
    opt = true,
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      vim.cmd [[ let g:db_ui_auto_execute_table_helpers = 1 ]]
      vim.api.nvim_set_keymap('n', 'gj', '<cmd>DBUI<CR>', { noremap = true, silent = true })
    end,
    requires = {
      {
        'tpope/vim-dadbod',
        event = 'BufRead',
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        config = function()
          vim.cmd [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
        end,
        event = 'BufRead',
      },
    },
    event = 'BufRead',
  }

  -- use {
  --   'github/copilot.vim',
  -- }
end)
