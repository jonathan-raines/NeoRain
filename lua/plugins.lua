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
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient').enable_profile()
    end,
  }

  use {
    { 'nathom/filetype.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
  }

  ---------- Database ----------
  -- use {
  --   'kristijanhusak/vim-dadbod-ui',
  --   config = function()
  --     require './configs/vim-dadbod-ui'
  --   end,
  --   requires = {
  --     {
  --       'tpope/vim-dadbod',
  --       event = 'BufRead',
  --     },
  --     {
  --       'kristijanhusak/vim-dadbod-completion',
  --       config = function()
  --         vim.cmd [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
  --       end,
  --       after = 'vim-dadbod',
  --     },
  --   },
  --   after = 'vim-dadbod',
  -- }
  ------------------------------

  ---------- Telescope ----------
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/telescope'
    end,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons', after = 'telescope.nvim' },
    },
    cmd = {"Telescope"},
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
      local telescope_status_ok, telescope = pcall(require, 'telescope')
      if not telescope_status_ok then
        return
      end

      telescope.setup {
        extensions = {
          file_browser = {
            theme = 'ivy',
            mappings = {
              ['i'] = {},
              ['n'] = {},
            },
          },
        },
      }

      require('telescope').load_extension 'file_browser'
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
    config = function()
      require('octo').setup()
    end,
    cmd = 'Octo',
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
    event = 'BufRead',
  }

  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require './configs/lsp'
    end,
    after = 'nvim-lspconfig',
  }

  -- use {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   config = function()
  --     require './configs/null-ls'
  --   end,
  --   requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   event = 'BufRead',
  -- }
  -------------------------

  ---------- MISC ----------
  -- use {
  --   'vim-test/vim-test',
  --   config = function()
  --     vim.cmd [[ let test#strategy = "harpoon" ]]
  --   end,
  --   requires = { 'ThePrimeagen/harpoon' },
  --   cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  --   opt = true,
  -- }

  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require './configs/rest'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    ft = { 'http' },
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {}
    end,
    cmd = { 'Trouble', 'TroubleToggle' },
    opt = true,
  }

  use {
    'KadoBOT/nvim-spotify',
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/nvim-spotify'
    end,
    run = 'make',
    after = 'telescope.nvim',
    cmd = { 'Spotify', 'SpotifyDevices' },
    opt = true,
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
          { 'rafamadriz/friendly-snippets', event = 'InsertEnter' },
        },
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

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  --------------------------------

  -------------- UI -----------------
  use {
    'shaunsingh/nord.nvim',
    config = function()
      require('nord').set()
      vim.cmd [[colorscheme nord]]
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

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require './configs/nvim-toggleterm'
    end,
    event = 'BufEnter',
  }
  --------------------------------
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
