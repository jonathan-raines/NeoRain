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

  ---------------
  -- Telescope --
  ---------------

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
    },
    setup = function()
      require 'configs.telescope-nvim'.setup()
    end,
    config = function()
      require 'configs.telescope-nvim'.config()
    end,
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

  ---------
  -- Git --
  ---------

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'configs.gitsigns'.config()
    end,
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

  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
    ft = { 'dart' }
  }

  use { 'gpanders/editorconfig.nvim' }

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
    'NTBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'configs.rest'
    end,
    ft = { 'http' }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    setup = function()
      vim.keymap.set('n', '<leader>fe', '<cmd>NvimTreeToggle<CR>',
        { noremap = true, silent = true, desc = { 'Nvim Tree Toggle' } })
    end,
    config = function()
      require 'nvim-tree'.setup {}
    end,
    tag = 'nightly',
    cmd = { 'NvimTreeToggle' }
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    setup = function()
      require './configs/nvim-toggleterm'.setup()
    end,
    config = function()
      require './configs/nvim-toggleterm'.config()
    end,
    tag = 'v2.*'
  }

  use {
    'jinh0/eyeliner.nvim',
    config = function()
      require 'eyeliner'.setup {
        highlight_on_key = true
      }
    end
  }

  --------------------
  -- Autocompletion --
  --------------------

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        requires = { { 'rafamadriz/friendly-snippets', event = 'InsertEnter' } },
        config = function()
          require 'luasnip/loaders/from_vscode'.lazy_load()
        end,
        after = 'friendly-snippets'
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
    after = 'LuaSnip'
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
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require 'configs.treesitter-textobjects'.config()
    end
  }

  -------------------
  -- COLOR SCHEMES --
  -------------------

  use {
    'tanvirtin/monokai.nvim',
    config = function()
      vim.cmd [[ colorscheme monokai_pro ]]
    end,
    event = 'ColorSchemePre'
  }

  use {
    'dracula/vim',
    config = function()
      vim.cmd [[ colorscheme dracula ]]
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
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'configs.bufferline'
    end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = "require 'configs.lualine'",
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
