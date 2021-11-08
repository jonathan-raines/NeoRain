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
    { 'nvim-treesitter/playground', event = 'BufRead' },
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
  ------------------------------

  ---------- Fuzzy Finding ----------
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/telescope'
    end,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzy-native.nvim',
        config = function()
          require('telescope').load_extension 'fzy_native'
        end,
        run = 'make',
        after = 'telescope.nvim',
      },
    },
    after = 'which-key.nvim',
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

  use {
    'TimUntersberger/neogit',
    config = function()
      require './configs/neogit'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
    cmd = 'Neogit',
    opt = true,
  }
  ----------------------------

  ---------- Javascript ----------
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
  --------------------------------

  ---------- Language Specific ----------
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
  }

  use {
    'tpope/vim-rails',
    ft = { 'ruby', 'rake' },
  }

  use {
    'akinsho/flutter-tools.nvim',
    config = function()
      require('flutter-tools').setup {
        lsp = {
          on_attach = _G_custom_on_attach,
        },
      }

      require('which-key').register({
        f = {
          y = { '<cmd>Telescope flutter commands theme=dropdown<cr>', 'Flutter Commands' },
        },
      }, {
        prefix = '<leader>',
      })
    end,
    requires = 'nvim-lua/plenary.nvim',
    ft = { 'dart' },
  }
  ---------------------------------------

  ---------- LSP ----------
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require './configs/nvim-lsp-installer'
    end,
    after = 'nvim-lspconfig',
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require './configs/nvim-lspconfig'
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
  -------------------------
  ---------- Marks ----------
  use {
    'ThePrimeagen/harpoon',
    config = function()
      require './configs/harpoon'
    end,
    requires = { 'popup.nvim', 'plenary.nvim' },
    event = 'BufEnter',
  }

  use {
    'chentau/marks.nvim',
    config = function()
      require './configs/marks'
    end,
    event = 'BufRead',
  }
  ---------------------------

  ---------- MISC ----------
  use {
    'vim-test/vim-test',
    config = function()
      vim.cmd [[ let test#strategy = "harpoon" ]]
    end,
    requires = { 'ThePrimeagen/harpoon' },
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
  }

  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
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

  -- use {
  --   'tpope/vim-unimpaired',
  --   event = 'BufEnter',
  -- }
  -- use {
  --   'github/copilot.vim',
  -- }
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

  ----------- Keep One Surround -----------
  -- use {
  --   'tpope/vim-surround',
  --   event = 'BufRead',
  -- }

  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require('surround').setup { mappings_style = 'surround' }
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
  --------------------------------

  -------------- UI -----------------
  use {
    'Mofiqul/dracula.nvim',
    config = function()
      require './configs/dracula'
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
    'akinsho/bufferline.nvim',
    config = function()
      require './configs/bufferline'
    end,
    requires = 'kyazdani42/nvim-web-devicons',
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
    event = 'BufRead',
  }
  --------------------------------
  use {
    'ThePrimeagen/refactoring.nvim',
    config = function()
      local refactor = require 'refactoring'
      refactor.setup()

      local function refactor(prompt_bufnr)
        local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
        require('telescope.actions').close(prompt_bufnr)
        require('refactoring').refactor(content.value)
      end

      M = {}
      M.refactors = function()
        local opts = require('telescope.themes').get_cursor() -- set personal telescope options
        require('telescope.pickers').new(opts, {
          prompt_title = 'refactors',
          finder = require('telescope.finders').new_table {
            results = require('refactoring').get_refactors(),
          },
          sorter = require('telescope.config').values.generic_sorter(opts),
          attach_mappings = function(_, map)
            map('i', '<CR>', refactor)
            map('n', '<CR>', refactor)
            return true
          end,
        }):find()
      end

      vim.api.nvim_set_keymap(
        'v',
        '<Leader>re',
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        { noremap = true, silent = true, expr = false }
      )
      vim.api.nvim_set_keymap(
        'v',
        '<Leader>rf',
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        { noremap = true, silent = true, expr = false }
      )
      vim.api.nvim_set_keymap('v', '<Leader>rt', [[ <Esc><Cmd>lua M.refactors()<CR>]], { noremap = true, silent = true, expr = false })
    end,
    ft = { 'go', 'lua', 'js', 'py', 'ts' },
  }
end)
