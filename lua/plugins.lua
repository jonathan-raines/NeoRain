-- Automatically install packr
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
  vim.cmd [[packadd packer.nvim]]
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
  use {
    {
      'wbthomason/packer.nvim',
      config = function()
        require 'configs.packer.setup'
      end,
    },
    {
      'lewis6991/impatient.nvim',
      config = function()
        require('impatient').enable_profile()
      end,
    },
    { 'nathom/filetype.nvim' },
    { 'nvim-lua/plenary.nvim' },
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
        after = 'vim-dadbod-ui',
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        config = function()
          vim.cmd [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
        end,
        after = 'vim-dadbod',
      },
    },
    cmd = { 'DBUI', 'DBUIToggle' },
  }
  ------------------------------

  ---------- Telescope ----------
  use {
    'nvim-telescope/telescope.nvim',
    setup = function()
      require 'configs.telescope.setup'
    end,
    config = function()
      require 'configs.telescope.config'
    end,
    requires = {
      -- { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons', after = 'telescope.nvim' },
    },
    cmd = { 'Telescope' },
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
    run = 'make',
    after = 'telescope.nvim',
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    config = function()
      require './configs/telescope-file-browser'
    end,
    after = 'telescope.nvim',
  }
  -----------------------------------

  ---------- Github ----------
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require './configs/gitsigns'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  }

  use {
    'pwntester/octo.nvim',
    setup = function()
      require 'configs.octo.setup'
    end,
    config = function()
      require('octo').setup()
    end,
    cmd = 'Octo',
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
      require './configs/lsp'
    end,
    event = 'BufReadPre',
  }

  use {
    'mhartington/formatter.nvim',
    config = function()
      require './configs/formatter-nvim'
    end,
    event = 'BufWritePre',
  }
  -------------------------

  ---------- MISC ----------
  use {
    'vim-test/vim-test',
    setup = function()
      require 'configs.vim-test.setup'
    end,
    config = function()
      require 'configs.vim-test.config'
    end,
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  }

  use {
    'gukz/ftFT.nvim',
    config = function()
      require './configs/ftFT'
    end,
    event = 'BufRead',
  }

  use {
    'ThePrimeagen/harpoon',
    setup = function()
      require 'configs.harpoon.setup'
    end,
    config = function()
      require 'configs.harpoon.config'
    end,
    module = 'harpoon',
  }

  use {
    'dstein64/vim-startuptime',
    config = [[vim.g.startuptime_tries = 10]],
    cmd = 'StartupTime',
  }
  ------------------------------

  ---------- Completion ----------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
        requires = {
          { 'rafamadriz/friendly-snippets' },
        },
        after = 'nvim-cmp',
      },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'lukas-reineke/cmp-under-comparator', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
    },
    config = function()
      require './configs/nvim-cmp'
    end,
    event = 'InsertEnter *',
  }
  ------------------------------

  ---------- Text Editing ----------
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
  -----------------------------------------

  ---------- Treesitter ----------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require './configs/nvim-treesitter'
    end,
    event = 'BufRead',
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    setup = function()
      local mappings = {
        d = {
          name = 'Peek',
          f = { 'Peek Function' },
          F = { 'Peek Class' },
        },
      }

      require('which-key').register(mappings, { prefix = '<leader>' })
    end,
    config = function()
      require './configs/nvim-treesitter-textobjects'
    end,
    after = 'nvim-treesitter',
  }

  use {
    'RRethy/nvim-treesitter-textsubjects',
    config = function()
      require './configs/nvim-treesitter-textsubjects'
    end,
    after = 'nvim-treesitter',
  }
  --------------------------------

  -------------- UI -----------------
  use {
    'catppuccin/nvim',
    config = function()
      require './configs/catppuccin'
    end,
    as = 'catppuccin',
    after = 'lualine.nvim',
    cmd = 'colorscheme catppuccin',
    disable = false,
  }

  use {
    'ellisonleao/gruvbox.nvim',
    after = 'lualine.nvim',
    cmd = 'colorscheme gruvbox',
    disable = false,
  }

  use {
    'eddyekofo94/gruvbox-flat.nvim',
    after = 'lualine.nvim',
    cmd = 'colorscheme gruvbox-flat',
    disable = true,
  }

  use {
    'savq/melange',
    after = 'lualine.nvim',
    cmd = 'colorscheme melange',
    disable = false,
  }

  use {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd [[colorscheme kanagawa]]
    end,
    after = 'lualine.nvim',
    disable = false,
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require './configs/lualine'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require './configs/which-key'
    end,
    disable = false,
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    setup = function()
      require 'configs.nvim-toggleterm.setup'
    end,
    config = function()
      require 'configs.nvim-toggleterm.config'
    end,
    event = 'BufWinEnter',
  }
  --------------------------------

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
