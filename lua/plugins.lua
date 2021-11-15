---@diagnostic disable: undefined-global
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
  }

  ---------- Database ----------
  use {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      require './configs/vim-dadbod-ui'
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
        after = 'vim-dadbod',
      },
    },
    after = 'vim-dadbod',
  }
  ------------------------------

  ---------- Fuzzy Finding ----------
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/telescope'
    end,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzy-native.nvim',
        config = function()
          require('telescope').load_extension 'fzy_native'
        end,
        run = 'make',
        after = 'telescope.nvim',
      },
      { 'kyazdani42/nvim-web-devicons', after = 'telescope.nvim' },
    },
    after = 'which-key.nvim',
  }
  -----------------------------------

  ---------- Github ----------
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require './configs/gitsigns'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufEnter',
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
    'TimUntersberger/neogit',
    config = function()
      require './configs/neogit'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    cmd = 'Neogit',
    opt = true,
  }
  ----------------------------

  ---------- Language Specific ----------
  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    ft = { 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'nvim-treesitter',
    ft = { 'js', 'css', 'html', 'vue', 'lua' },
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
  }

  use {
    'tpope/vim-rails',
    ft = { 'ruby', 'rake' },
  }

  use {
    'akinsho/flutter-tools.nvim',
    config = function()
      require './configs/flutter-tools'
    end,
    requires = 'nvim-lua/plenary.nvim',
    ft = { 'dart' },
  }
  ---------------------------------------

  ---------- LSP ----------
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require './configs/nvim-lspconfig'
    end,
    event = 'BufReadPre',
  }

  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require './configs/nvim-lsp-installer'
    end,
    after = 'nvim-lspconfig',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require './configs/null-ls'
    end,
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    event = 'BufReadPre',
  }
  -------------------------

  ---------- Marks ----------
  use {
    'ThePrimeagen/harpoon',
    config = function()
      require './configs/harpoon'
    end,
    requires = { 'popup.nvim', 'plenary.nvim' },
    event = 'BufEnter',
  }
  ---------------------------

  ---------- MISC ----------
  use {
    'vim-test/vim-test',
    config = function()
      vim.cmd [[ let test#strategy = "harpoon" ]]
    end,
    requires = { 'ThePrimeagen/harpoon' },
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
    opt = true,
  }

  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    opt = true,
  }

  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require './configs/rest'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    ft = { 'http' },
  }
  ------------------------------

  ---------- Text Editing ----------
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require './configs/nvim-cmp'
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
        requires = {
          { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
          { 'rafamadriz/friendly-snippets', after = 'nvim-autopairs' },
        },
        event = 'InsertEnter',
      },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      after = 'friendly-snippets',
    },
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require './configs/nvim-autopairs'
    end,
    event = 'InsertEnter',
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require './configs/comment'
    end,
    event = 'BufRead',
  }

  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require('surround').setup { mappings_style = 'sandwich' }
    end,
    event = 'BufRead',
  }

  use {
    'ThePrimeagen/refactoring.nvim',
    config = function()
      require './configs/refactoring'
    end,
    event = 'BufRead',
    ft = { 'go', 'lua', 'js', 'py', 'ts' },
  }
  -----------------------------------------

  ---------- Treesitter ----------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require './configs/nvim-treesitter'
    end,
  }
  --------------------------------

  -------------- UI -----------------
  use {
    'Mofiqul/dracula.nvim',
    config = function()
      require './configs/dracula'
    end,
    after = 'lualine.nvim',
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require './configs/lualine'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'UIEnter',
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require './configs/which-key'
    end,
  }

  -- use {
  --   'akinsho/nvim-toggleterm.lua',
  --   config = function()
  --     require './configs/nvim-toggleterm'
  --   end,
  --   event = 'BufRead',
  -- }
  --------------------------------
end)
