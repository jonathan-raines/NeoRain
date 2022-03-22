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
      config = "require 'configs.packer.setup'",
    },
    {
      'lewis6991/impatient.nvim',
      config = "require('impatient').enable_profile()",
    },
    { 'nathom/filetype.nvim' },
    { 'nvim-lua/plenary.nvim' },
  }

  ---------- Database ----------
  use {
    'kristijanhusak/vim-dadbod-ui',
    config = "require 'configs.vim-dadbod-ui'",
    requires = {
      { 'tpope/vim-dadbod', after = 'vim-dadbod-ui' },
      { 'kristijanhusak/vim-dadbod-completion', after = 'vim-dadbod' },
    },
    cmd = { 'DBUI', 'DBUIToggle' },
  }
  ------------------------------

  ---------- Telescope ----------
  use {
    'nvim-telescope/telescope.nvim',
    setup = "require 'configs.telescope.setup'",
    config = "require 'configs.telescope.config'",
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons', after = 'telescope.nvim' },
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
  -----------------------------------

  ---------- Github ----------
  use {
    'lewis6991/gitsigns.nvim',
    config = "require 'configs.gitsigns'",
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  }

  use {
    'pwntester/octo.nvim',
    setup = "require 'configs.octo.setup'",
    config = "require('octo').setup()",
    cmd = { 'Octo' },
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
    config = "require 'configs.flutter-tools'",
    requires = 'nvim-lua/plenary.nvim',
    ft = { 'dart' },
  }
  ---------------------------------------

  ---------- LSP ----------
  use {
    'neovim/nvim-lspconfig',
    config = "require 'configs.lsp'",
    event = 'BufReadPre',
  }

  use {
    'mhartington/formatter.nvim',
    config = "require 'configs.formatter-nvim'",
    event = 'BufWritePre',
  }
  -------------------------

  ---------- MISC ----------
  use {
    'vim-test/vim-test',
    setup = "require 'configs.vim-test.setup'",
    config = "require 'configs.vim-test.config'",
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  }

  use {
    'gukz/ftFT.nvim',
    config = "require 'configs.ftFT'",
    event = 'BufRead',
  }

  use {
    'ThePrimeagen/harpoon',
    setup = "require 'configs.harpoon.setup'",
    config = "require 'configs.harpoon.config'",
    module = 'harpoon',
  }

  use {
    'dstein64/vim-startuptime',
    config = 'vim.g.startuptime_tries = 10',
    cmd = { 'StartupTime' },
  }

  use {
    'NTBBloodbath/rest.nvim',
    setup = "require('configs.rest.setup')",
    config = "require('configs.rest.config')",
    requires = { 'nvim-lua/plenary.nvim' },
    ft = { 'http' },
  }
  ------------------------------

  ---------- Completion ----------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = " require('luasnip/loaders/from_vscode').lazy_load()",
        requires = {
          { 'rafamadriz/friendly-snippets', event = 'InsertEnter' },
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
    config = "require 'configs.nvim-cmp'",
    event = 'InsertEnter *',
  }
  ------------------------------

  ---------- Text Editing ----------
  use {
    'windwp/nvim-autopairs',
    config = "require 'configs.nvim-autopairs'",
    event = 'InsertEnter',
  }

  use {
    'numToStr/Comment.nvim',
    config = "require 'configs.comment'",
    event = 'BufRead',
  }
  -----------------------------------------

  ---------- Treesitter ----------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = "require 'configs.nvim-treesitter'",
    event = 'BufRead',
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    setup = "require 'configs.treesitter-textobjects.setup'",
    config = "require 'configs.treesitter-textobjects.config'",
    after = 'nvim-treesitter',
  }

  use {
    'RRethy/nvim-treesitter-textsubjects',
    config = "require 'configs.nvim-treesitter-textsubjects'",
    after = 'nvim-treesitter',
  }
  --------------------------------

  -------------- UI -----------------
  use {
    'catppuccin/nvim',
    config = "require 'configs.themes.catppuccin'",
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
    'rebelot/kanagawa.nvim',
    config = "require 'configs.themes.kanagawa'",
    after = 'lualine.nvim',
    disable = false,
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = "require 'configs.lualine'",
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'folke/which-key.nvim',
    config = "require 'configs.which-key'",
    disable = false,
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    setup = "require 'configs.nvim-toggleterm.setup'",
    config = "require 'configs.nvim-toggleterm.config'",
    event = 'BufWinEnter',
  }
  --------------------------------

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
