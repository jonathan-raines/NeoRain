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
    setup = function()
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Telescope
      keymap('n', '<leader>fb', '<cmd>Telescope buffers theme=get_ivy<CR>', opts)
      keymap('n', '<leader>fc', '<cmd>Telescope colorscheme<CR>', opts)
      keymap('n', '<leader>fd', '<cmd>Telescope lsp_document_symbols<CR>', opts)
      keymap('n', '<leader>fe', '<cmd>Telescope file_browser<CR>', opts)
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
      keymap('n', '<leader>fo', '<cmd>Telescope oldfiles cwd_only=v:true<CR>', opts)
      keymap('n', '<leader>fq', '<cmd>Telescope quickfix<CR>', opts)
      keymap('n', '<leader>fr', '<cmd>Telescope resume<CR>', opts)
      keymap('n', '<leader>fs', '<cmd>Telescope grep_string<CR>', opts)
      keymap('n', '<leader>ft', '<cmd>Telescope treesitter<CR>', opts)
      keymap('n', '<leader>fw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opts)
      keymap('n', '<leader>/', '<cmd>lua _CURR_BUF()<CR>', opts)

      local mappings = {
        f = {
          name = 'Telescope',
          b = { 'Buffers' },
          c = { 'Colorscheme' },
          d = { 'Document Symbols' },
          f = { 'Find Files' },
          e = { 'File Browser' },
          g = { 'Live Grep' },
          o = { 'Open Recent File' },
          q = { 'Open Quickfix' },
          r = { 'Resume Last Picker' },
          s = { 'Grep String' },
          t = { 'Treesitter' },
          w = { 'Workplace Symbols' },
        },
        ['/'] = { 'Search Current Buffer' },
      }

      require('which-key').register(mappings, { prefix = '<leader>' })
    end,
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
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Octo
      keymap('n', '<leader>oic', '<cmd>Octo issue create<CR>', opts)
      keymap('n', '<leader>oil', '<cmd>Octo issue list<CR>', opts)
      keymap('n', '<leader>op', '<cmd>Octo pr list<CR>', opts)
      keymap('n', '<leader>ors', '<cmd>Octo review start<CR>', opts)
      keymap('n', '<leader>orf', '<cmd>Octo review submit<CR>', opts)

      local mappings = {
        o = {
          name = 'Octo',
          i = {
            name = 'Issues',
            c = { 'Create Issue' },
            l = { 'List Issues' },
          },
          p = { 'List Pull Requests' },
          r = {
            name = 'Review',
            s = { 'Start Review' },
            f = { 'Submit Review' },
          },
        },
      }

      require('which-key').register(mappings, { prefix = '<leader>' })
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
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Vim-Test
      keymap('n', '<leader>tf', '<cmd>TestFile<CR>', opts)
      keymap('n', '<leader>tl', '<cmd>TestLast<CR>', opts)
      keymap('n', '<leader>tn', '<cmd>TestNearest<CR>', opts)
      keymap('n', '<leader>ts', '<cmd>TestSuite<CR>', opts)
      keymap('n', '<leader>tv', '<cmd>TestVisit<CR>', opts)

      local mappings = {
        t = {
          name = 'Testing',
          f = { 'Run Test File' },
          l = { 'Run Last Test' },
          n = { 'Run Nearest Test' },
          s = { 'Run Test Suite' },
          v = { 'Visit Test File' },
        },
      }

      require('which-key').register(mappings, { prefix = '<leader>' })
    end,
    config = function()
      require './configs/vim-test'
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
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Harpoon
      keymap('n', '<leader>hp', '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
      keymap('n', '<leader>hq', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
      keymap('n', '<leader>ha', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', opts)
      keymap('n', '<leader>hs', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', opts)
      keymap('n', '<leader>hd', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', opts)
      keymap('n', '<leader>hf', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', opts)
      keymap('n', '<leader>ht', '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>', opts)
      keymap('n', '<leader>hy', '<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>', opts)
      keymap('n', '<leader>hl', '<cmd>lua require("harpoon.tmux").sendCommand(99, "lazygit && exit")<CR>', opts)

      local mappings = {
        h = {
          name = 'Harpoon',
          p = { 'Add File' },
          q = { 'Menu' },
          a = { 'Navigate to File 1' },
          s = { 'Navigate to File 2' },
          d = { 'Navigate to File 3' },
          f = { 'Navigate to File 4' },
          t = { 'Navigate to Terminal 1' },
        },
      }

      require('which-key').register(mappings, { prefix = '<leader>' })
    end,
    config = function()
      require './configs/harpoon'
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
      local mappings = {
        j = {
          name = 'Terminal',
          l = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
        },
      }

      require('which-key').register(mappings, { prefix = '<leader>' })
    end,
    config = function()
      require './configs/nvim-toggleterm'
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
