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
  use {
    { 'wbthomason/packer.nvim' },
    {
      'lewis6991/impatient.nvim',
      config = function()
        require('impatient').enable_profile()
      end,
    },
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
    config = function()
      require './configs/telescope'
    end,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons', after = 'telescope.nvim' },
    },
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
      require('telescope').setup {
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

  use {
    'ThePrimeagen/harpoon',
    config = function()
      require './configs/harpoon'
    end,
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

  use {
    'tpope/vim-rails',
    ft = { 'ruby' },
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

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require './configs/null-ls'
    end,
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    event = 'BufRead',
  }
  -------------------------

  ---------- MISC ----------
  use {
    'vim-test/vim-test',
    config = function()
      vim.api.nvim_exec(
        [[
          function! DockerTransform(cmd)
            return "docker-compose exec $(tmux display-message -p '#S') " .a:cmd
          endfunction]],
        false
      )
      vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')}]]
      vim.cmd [[ let test#transformation = 'docker']]
      vim.cmd [[ let test#strategy = "harpoon" ]]
    end,
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  }

  use {
    'KadoBOT/nvim-spotify',
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/nvim-spotify'
    end,
    run = 'make',
  }
  ------------------------------

  ---------- Completion ----------
  use { 'rafamadriz/friendly-snippets' }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip/loaders/from_vscode').lazy_load()
    end,
    requires = {
      { 'rafamadriz/friendly-snippets' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require './configs/nvim-cmp'
    end,
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
    },
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

  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require('surround').setup { mappings_style = 'sandwich' }
    end,
    commit = '00c384773a5a0b7cd556113dc7b3ab5799f6fdbc',
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

  use {
    'SmiteshP/nvim-gps',
    config = function()
      require('nvim-gps').setup()
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
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
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require './configs/nvim-toggleterm'
    end,
  }

  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

  use {
    'unblevable/quick-scope',
    config = function()
      vim.cmd [[
        augroup qs_colors
          autocmd!
          autocmd ColorScheme * highlight QuickScopePrimary gui=underline cterm=underline
          autocmd ColorScheme * highlight QuickScopeSecondary gui=underline cterm=underline
        augroup END
      ]]
    end,
  }
  --------------------------------
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
