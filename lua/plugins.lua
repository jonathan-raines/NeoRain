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

  use { 'wbthomason/packer.nvim', config = "require 'configs.packer'.setup()" }

  ----------------------
  -- Required plugins --
  ----------------------

  use { 'lewis6991/impatient.nvim', config = "require('impatient').enable_profile()" }

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
    setup = "require 'configs.telescope'.setup()",
    config = "require 'configs.telescope'.config()",
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
    },
    cmd = { 'Telescope' },
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    config = "require('telescope').load_extension 'fzf'",
    run = 'make',
    after = 'telescope.nvim',
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    config = "require 'configs.telescope-file-browser'",
    after = 'telescope.nvim',
  }

  ------------
  -- Github --
  ------------

  use {
    'lewis6991/gitsigns.nvim',
    config = "require 'configs.gitsigns'.config()",
    requires = { 'nvim-lua/plenary.nvim' },
  }

  ---------------------
  -- Language Server --
  ---------------------

  use {
    'neovim/nvim-lspconfig',
    config = "require 'configs.lsp'",
  }

  ----------
  -- MISC --
  ----------

  use {
    'vim-test/vim-test',
    setup = "require 'configs.vim-test'.setup()",
    config = "require 'configs.vim-test'.config()",
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  }

  use {
    'windwp/nvim-autopairs',
    config = "require 'configs.nvim-autopairs'",
    event = 'InsertEnter',
  }

  use {
    'numToStr/Comment.nvim',
    config = "require 'configs.comment'",
  }

  use {
    'NTBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'configs.rest'
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
        config = " require('luasnip/loaders/from_vscode').lazy_load()",
        requires = { { 'rafamadriz/friendly-snippets' } },
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    },
    config = "require 'configs.nvim-cmp'",
    event = 'InsertEnter',
  }

  ----------------
  -- Treesitter --
  ----------------

  use {
    'nvim-treesitter/nvim-treesitter',
    config = "require 'configs.nvim-treesitter'",
    run = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' }
  }

  -------------------
  -- COLOR SCHEMES --
  -------------------

  -- use { 'navarasu/onedark.nvim',
  --   config = function()
  --     require 'onedark'.load()
  --   end,
  -- }

  use { 'sainnhe/gruvbox-material', }

  use {
    'sainnhe/sonokai',
    config = 'vim.cmd[[colorscheme sonokai]]'
  }

  use 'Tsuzat/NeoSolarized.nvim'

  -----------------
  -- UI Elements --
  -----------------

  use {
    'folke/which-key.nvim',
    config = "require 'configs.which-key'.config()",
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = "require 'configs.lualine'",
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require 'packer'.sync()
  end
end)
