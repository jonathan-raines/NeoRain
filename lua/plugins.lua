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
      require 'configs.telescope.telescope-nvim'.setup()
    end,
    config = function()
      require 'configs.telescope.telescope-nvim'.config()
    end,
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    config = function()
      require 'configs.telescope.telescope-fzf-native'
    end,
    run = 'make',
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    config = "require 'configs.telescope.telescope-file-browser'",
  }

  -- Possible Delete
  use {
    'otavioschwanck/telescope-alternate.nvim',
    setup = function()
      require 'configs.telescope.telescope-alternate'.setup()
    end,
    config = function()
      require 'configs.telescope.telescope-alternate'.config()
    end,
  }

  -- Possible Delete
  use {
    'LukasPietzschmann/telescope-tabs',
    requires = { 'nvim-telescope/telescope.nvim' },
    setup = function()
      require 'configs.telescope.telescope-tabs'.setup()
    end,
    config = function()
      require 'configs.telescope.telescope-tabs'.config()
    end
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
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
  }

  use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'flutter-tools'.setup {}
    end,
    ft = { 'dart' }
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
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' }
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'configs.nvim-autopairs'
    end,
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'configs.comment'
    end,
  }

  use {
    'kylechui/nvim-surround',
    config = function()
      require 'nvim-surround'.setup {}
    end
  }

  use {
    'jinh0/eyeliner.nvim',
    config = function()
      require 'configs.eyeliner'
    end
  }

  use {
    'cbochs/grapple.nvim',
    config = function()
      require 'configs.grapple'.config()
    end
  }

  use {
    'cbochs/portal.nvim',
    setup = function()
      require 'configs.portal'.setup()
    end,
    config = function()
      require 'configs.portal'.config()
    end,
    requires = {
      'cbochs/grapple.nvim'
    },
  }

  use {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup {}
    end,
    ft = { 'lua' }
  }

  --------------------
  -- Autocompletion --
  --------------------

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        requires = {
          { 'rafamadriz/friendly-snippets', }
        },
        config = function()
          require 'luasnip/loaders/from_vscode'.lazy_load()
        end,
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
    },
    config = function()
      require 'configs.nvim-cmp'
    end,
  }

  ----------------
  -- Treesitter --
  ----------------

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'configs.treesitter.nvim-treesitter'
    end,
    run = function()
      require 'nvim-treesitter.install'.update { with_sync = true }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require 'configs.treesitter.treesitter-textobjects'.config()
    end,
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require 'configs.treesitter.nvim-ts-context-commentstring'
    end
  }

  use {
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
    config = function()
      require 'treesj'.setup {}
    end,
  }

  -------------------
  -- COLOR SCHEMES --
  -------------------

  use {
    'Mofiqul/dracula.nvim',
    config = function()
      require 'configs.colorschemes.dracula'
    end,
    event = 'ColorSchemePre'
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      require 'configs.colorschemes.tokyonight'
    end,
    event = 'ColorSchemePre'
  }

  use {
    'sainnhe/sonokai',
    config = function()
      require 'configs.colorschemes.sonokai'

      vim.cmd [[ colorscheme sonokai ]]
    end
  }

  -----------------
  -- UI Elements --
  -----------------

  use {
    'nanozuki/tabby.nvim',
    setup = function()
      require 'configs.tabby'.setup()
    end,
    config = function()
      require 'configs.tabby'.config()
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require 'configs.which-key'.config()
    end,
  }

  use {
    'akinsho/toggleterm.nvim',
    tag = '*',
    setup = function()
      require 'configs.toggleterm-nvim'.setup()
    end,
    config = function()
      require 'configs.toggleterm-nvim'.config()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
