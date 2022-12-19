local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd.packadd 'packer.nvim'
end

vim.api.nvim_create_augroup('PackerUserConfig', { clear = true })
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
  use 'lewis6991/impatient.nvim'

  ---------------
  -- Telescope --
  ---------------
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
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
      require 'telescope'.load_extension 'fzf'
    end,
    run = 'make',
    cond = vim.fn.executable 'make' == 1
  }

  ---------
  -- Git --
  ---------
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'configs.gitsigns'.config()
    end,
  }

  use {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gg', vim.cmd.Git, { desc = 'Fugitive' })
    end
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
    'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require 'nvim-treesitter.configs'.setup {
          context_commentstring = { enable = true }
        }
      end
    },
    config = function()
      require 'Comment'.setup {
        ignore = '^$',
        pre_hook = require 'ts_context_commentstring.integrations.comment_nvim'.create_pre_hook(),
      }
    end
  }

  use {
    'cbochs/grapple.nvim',
    setup = function()
      require 'configs.grapple'.setup()
    end,
    config = function()
      require 'configs.grapple'.config()
    end
  }

  use {
    'mbbill/undotree',
    setup = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })
    end,
    cmd = 'UndotreeToggle'
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
      },
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
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

  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }

  -------------------
  -- COLOR SCHEMES --
  -------------------
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if is_bootstrap then
    packer.sync()
  end
end)
