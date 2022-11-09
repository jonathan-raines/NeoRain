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
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    config = function()
      require 'configs.telescope-fzf-native'
    end,
    run = 'make',
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    config = "require 'configs.telescope-file-browser'",
  }

  use {
    'otavioschwanck/telescope-alternate.nvim',
    setup = function()
      require 'configs.telescope-alternate'.setup()
    end,
    config = function()
      require 'configs.telescope-alternate'.config()
    end,
  }

  use {
    'LukasPietzschmann/telescope-tabs',
    requires = { 'nvim-telescope/telescope.nvim' },
    setup = function()
      vim.keymap.set('n', '<leader>v', '<cmd>Telescope telescope-tabs list_tabs initial_mode=normal<CR>',
        { silent = true, remap = true, desc = 'Tabs' })
    end,
    config = function()
      require 'telescope-tabs'.setup { show_preview = false }
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
    'jinh0/eyeliner.nvim',
    config = function()
      require 'eyeliner'.setup {
        highlight_on_key = true
      }
    end
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
    'ThePrimeagen/harpoon',
    setup = function()
      require 'configs.harpoon'.setup()
    end,
    config = function()
      require 'configs.harpoon'.config()
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
      require 'configs.nvim-treesitter'
    end,
    run = function()
      require 'nvim-treesitter.install'.update { with_sync = true }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require 'configs.treesitter-textobjects'.config()
    end,
  }

  -------------------
  -- COLOR SCHEMES --
  -------------------

  use {
    'dracula/vim', as = 'dracula',
    event = 'ColorSchemePre'
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      require 'configs.tokyonight'
    end
  }

  use {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_disable_terminal_colors = 1

      vim.cmd [[ colorscheme sonokai ]]
    end
  }

  -----------------
  -- UI Elements --
  -----------------

  use {
    'nanozuki/tabby.nvim',
    setup = function()
      vim.o.showtabline = 2
    end,
    config = function()
      require 'configs.tabby'
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
      require 'configs.toggleterm'.setup()
    end,
    config = function()
      require 'configs.toggleterm'.config()
    end
  }

  use {
    'ggandor/leap.nvim',
    config = function()
      require 'leap'.add_default_mappings()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
