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
      local telescope = require 'telescope'

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

      telescope.load_extension 'file_browser'
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
    'gukz/ftFT.nvim',
    config = function()
      vim.g.ftFT_sight_disable = 1 -- if set this, will not have sight line
      require('ftFT').setup()
    end,
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
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          lsp_interop = {
            enable = true,
            border = 'rounded',
            peek_definition_code = {
              ['df'] = '@function.outer',
              ['dF'] = '@class.outer',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          swap = {
            enable = false,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
    after = 'nvim-treesitter',
  }

  use {
    'RRethy/nvim-treesitter-textsubjects',
    config = function()
      require('nvim-treesitter.configs').setup {
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
          },
        },
      }
    end,
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
  --------------------------------

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
