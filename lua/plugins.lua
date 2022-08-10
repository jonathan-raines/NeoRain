-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.api.nvim_command [[packadd packer.nvim]]
end

vim.api.nvim_create_augroup('PackerUserConfig', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Reloads Neovim whenever you save the plugins.lua file',
  group = 'PackerUserConfig',
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

return packer.startup(function(use)
  ---------------------
  -- Package Manager --
  ---------------------

  use {
    'wbthomason/packer.nvim',
    config = function()
      require 'configs.packer'.setup()
    end
  }

  ----------------------
  -- Required plugins --
  ----------------------

  use {
    'lewis6991/impatient.nvim',
    config = function()
      require 'impatient'.enable_profile()
    end
  }

  --------------
  -- Database --
  --------------

  -- use {
  --   'kristijanhusak/vim-dadbod-ui',
  --   config = "require 'configs.vim-dadbod-ui'",
  --   requires = {
  --     { 'tpope/vim-dadbod', after = 'vim-dadbod-ui' },
  --     { 'kristijanhusak/vim-dadbod-completion', after = 'vim-dadbod' },
  --   },
  --   cmd = { 'DBUI', 'DBUIToggle' },
  -- }

  ---------------
  -- Telescope --
  ---------------

  use {
    'nvim-telescope/telescope.nvim',
    setup = function()
      require 'configs.telescope-nvim'.setup()
    end,
    config = function()
      require 'configs.telescope-nvim'.config()
    end,
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
    },
    cmd = { 'Telescope' },
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    config = function()
      require 'configs.telescope-fzf-native'
    end,
    run = 'make',
    after = 'telescope.nvim',
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    config = function()
      require 'configs.telescope-file-browser'
    end,
    after = 'telescope.nvim',
  }

  ---------
  -- Git --
  ---------

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'configs.gitsigns'.config()
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'octo'.setup()
    end,
    cmd = { 'Octo' }
  }

  ---------------------
  -- Language Server --
  ---------------------

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'configs.lsp'
    end
  }

  ----------
  -- MISC --
  ----------

  use {
    'vim-test/vim-test',
    setup = function()
      require 'configs.vim-test'.setup()
    end,
    config = function()
      require 'configs.vim-test'.config()
    end,
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'configs.nvim-autopairs'
    end,
    event = 'InsertEnter',
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'configs.comment'
    end,
    keys = { 'gc', 'gb' }
  }

  use {
    'kylechui/nvim-surround',
    config = function()
      require 'nvim-surround'.setup {}
    end,
  }

  use {
    'folke/twilight.nvim',
    config = function()
      require 'twilight'.setup {}
    end,
    cmd = { 'Twilight' }
  }

  use {
    'NTBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'configs.rest'
    end,
    ft = { 'http' }
  }

  --------------------
  -- Autocompletion --
  --------------------

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require 'luasnip/loaders/from_vscode'.lazy_load()
        end,
        requires = { { 'rafamadriz/friendly-snippets', event = 'InsertEnter' } },
        event = 'InsertEnter'
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    },
    config = function()
      require 'configs.nvim-cmp'
    end,
    event = 'InsertEnter',
  }

  ----------------
  -- Treesitter --
  ----------------

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'configs.nvim-treesitter'
    end,
    run = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' }
  }

  -------------------
  -- COLOR SCHEMES --
  -------------------

  use {
    'tanvirtin/monokai.nvim',
    config = function()
      vim.cmd [[ colorscheme monokai_pro ]]
    end
  }

  -----------------
  -- UI Elements --
  -----------------

  use {
    'folke/which-key.nvim',
    config = function()
      require 'configs.which-key'.config()
    end
  }

  use {
    'akinsho/bufferline.nvim',
    config = function()
      require 'configs.bufferline'
    end,
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'feline-nvim/feline.nvim',
    config = "require 'configs.feline'",
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'lewis6991/gitsigns.nvim' },
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
