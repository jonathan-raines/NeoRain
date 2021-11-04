local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'lewis6991/impatient.nvim',
    config = function()
      require 'impatient'
    end,
  }

  use {
    { 'nathom/filetype.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
  }

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/telescope'
    end,
    event = 'BufRead',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/playground', after = 'telescope.nvim' },
      {
        'camgraff/telescope-tmux.nvim',
        config = function()
          require('telescope').load_extension 'tmux'
        end,
        after = 'telescope.nvim',
      },
      {
        'nvim-telescope/telescope-fzy-native.nvim',
        config = function()
          require('telescope').load_extension 'fzy_native'
        end,
        run = 'make',
        after = 'telescope.nvim',
      },
    },
  }

  use {
    'Mofiqul/dracula.nvim',
    config = function()
      vim.g.dracula_show_end_of_buffer = true
      vim.cmd [[ colorscheme dracula ]]
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
    'lewis6991/gitsigns.nvim',
    config = function()
      require './configs/gitsigns'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    event = 'BufRead',
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require './configs/comment'
    end,
    event = 'BufRead',
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require './configs/treesitter'
    end,
    requires = {
      {
        'code-biscuits/nvim-biscuits',
        config = function()
          require('nvim-biscuits').setup {
            cursor_line_only = true,
          }
        end,
        after = 'nvim-treesitter',
      },
      {
        'nvim-treesitter/playground',
      },
    },
    event = 'BufEnter',
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require './configs/autopairs'
    end,
    event = 'InsertEnter',
  }

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
    'kyazdani42/nvim-tree.lua',
    config = function()
      require './configs/nvim-tree'
    end,
    requires = { 'kyazdani42/nvim-web-devicons' },
    cmd = 'NvimTreeToggle',
    opt = true,
  }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require 'servers'
    end,
    after = 'nvim-lspconfig',
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end,
    event = 'BufReadPre',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require './configs/null-ls'
    end,
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    event = 'BufReadPre',
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
  }

  -- Auto Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require './configs/cmp'
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
        requires = {
          { 'saadparwaiz1/cmp_luasnip' },
          { 'rafamadriz/friendly-snippets' },
        },
      },
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require './configs/whichkey'
    end,
    event = 'UIEnter',
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require './configs/toggleterm'
    end,
    event = 'BufRead',
  }

  use {
    'ThePrimeagen/harpoon',
    config = function()
      require './configs/harpoon'
    end,
    requires = { 'popup.nvim', 'plenary.nvim' },
    event = 'BufEnter',
  }

  use {
    'pwntester/octo.nvim',
    config = function()
      require('octo').setup()
    end,
    cmd = 'Octo',
    opt = true,
  }

  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require './configs/rest'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    ft = { 'http' },
  }

  use {
    'akinsho/flutter-tools.nvim',
    config = function()
      require('flutter-tools').setup {}
    end,
    requires = 'nvim-lua/plenary.nvim',
    ft = { 'dart' },
  }

  use {
    'chentau/marks.nvim',
    config = function()
      require './configs/marks'
    end,
    event = 'BufRead',
  }

  use {
    'echasnovski/mini.nvim',
    config = function()
      require './configs/mini'
    end,
    event = 'BufRead',
  }

  use {
    'romgrk/barbar.nvim',
    config = function()
      require './configs/barbar'
    end,
    requires = { 'kyazdani42/nvim-web-devicons' },
    event = 'BufRead',
  }

  -- TESTING
  use {
    'TimUntersberger/neogit',
    config = function()
      require './configs/neogit'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    cmd = 'Neogit',
    opt = true,
  }

  use {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      vim.cmd [[ let g:db_ui_auto_execute_table_helpers = 1 ]]
      vim.api.nvim_set_keymap('n', 'gj', ':DBUI<CR>', { noremap = true, silent = true })
      vim.cmd [[
        let g:dbs = [
        \  { 'name': 'app_manager_develop', 'url': 'postgres://postgres:welcome@localhost:5433/app_manager_backend_development' },
        \  { 'name': 'app_manager_test', 'url': 'postgres://postgres:welcome@localhost:5433/app_manager_backend_test' },
        \  { 'name': 'auth_develop', 'url': 'postgres://postgres:welcome@localhost:5433/oauth_service_development' },
        \  { 'name': 'auth_test', 'url': 'postgres://postgres:welcome@localhost:5433/oauth_service_test' },
        \  { 'name': 'media_develop', 'url': 'postgres://postgres:welcome@localhost:5433/thrillshare_development' },
        \  { 'name': 'media_test', 'url': 'postgres://postgres:welcome@localhost:5433/thrillshare_test' }
        \ ]
      ]]
    end,
    requires = {
      {
        'tpope/vim-dadbod',
        event = 'BufRead',
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        config = function()
          vim.cmd [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
        end,
        after = 'vim-dadbod',
      },
    },
    after = 'vim-dadbod',
  }

  use {
    'vim-test/vim-test',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tv', ':TestVisit<CR>', { noremap = true, silent = true })
    end,
    event = 'BufRead',
  }

  use {
    'tpope/vim-rails',
    ft = { 'ruby', 'rake' },
  }

  -- use {
  --   'github/copilot.vim',
  -- }
end)
