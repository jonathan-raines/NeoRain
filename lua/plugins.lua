local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'


if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
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
    end
  }

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'configs.telescope'
    end,
    event = "UIEnter",
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make', event = 'VimEnter' }
    },
    after = { 'telescope-fzy-native.nvim' }
  }

  -- UI
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.cmd [[colorscheme tokyonight]]
    end,
    event = "UIEnter"
  }

  use {
    'shadmansaleh/lualine.nvim',
    config = function()
      require('lualine').setup {
        sections = {},
        options = {
          component_separators = "",
          section_separators = "",
          theme = 'tokyonight'
        },
      }
    end,
    event = "UIEnter",
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '_' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' },
        },
      }
    end,
    event = 'BufRead',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup({
        comment_empty = false,
      })

      vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
    end,
    event = "BufRead"
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require 'configs.treesitter'
    end,
    event = "BufRead"
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'configs.autopairs'
    end,
    event = "InsertEnter"
  }

  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    ft = { 'vue', 'html' }
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = { 'js', 'css', 'html', 'vue', 'lua' },
    after = 'nvim-treesitter'
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function ()
      require 'configs.nvim-tree'
    end,
    event = "UIEnter",
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end
  }

  use {
    'kabouzeid/nvim-lspinstall',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function ()
      require 'configs.null-ls'
    end,
    event = 'BufReadPre',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    ft = { 'js', 'vue' },
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' }
  }

  -- Auto Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function ()
      require 'configs.cmp'
    end,
    requires = {
      'hrsh7th/cmp-buffer',
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require("luasnip/loaders/from_vscode").lazy_load()
        end,
        requires = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' }
      },
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

    }
  }

  use {
    'folke/which-key.nvim',
    config = function ()
      require 'configs.whichkey'
    end,
    event = "UIEnter"
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function ()
      require 'configs.toggleterm'
    end,
    event = 'VimEnter'
  }

  use {
    'ThePrimeagen/harpoon',
    event = 'UIEnter',
    requires = { 'popup.nvim', 'plenary.nvim'}
  }

  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
            enabled = true,
            timeout = 150,
        },
        -- Jump to request line on run
        jump_to_request = false,
        })
    vim.api.nvim_set_keymap('n', 'Q', "<cmd>lua require'rest-nvim'.run()<cr>", {noremap = true, silent = true})
    end,
    requires = { 'nvim-lua/plenary.nvim' },
}
end)
