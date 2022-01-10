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
    'LinArcX/telescope-command-palette.nvim',
    config = function()
      require('telescope').load_extension 'command_palette'
      CpMenu = {
        {
          'Telescope',
          { 'buffers (leader fb)', '<cmd>Telescope buffers theme=get_ivy<CR>' },
          { 'document symbols (leader fd)', '<cmd>Telescope lsp_document_symbols' },
          { 'file browser (leader fe)', ":lua require'telescope'.extensions.file_browser.file_browser()" },
          { 'find files (leader ff)', ":lua require('telescope.builtin').find_files()" },
          { 'find word (leader fg)', ":lua require('telescope.builtin').live_grep()" },
          { 'git files ()', ":lua require('telescope.builtin').git_files()" },
          { 'recent files (leader fo)', '<cmd>Telescope old_files<CR>' },
        },
        {
          'Help',
          { 'tips', ':help tips' },
          { 'cheatsheet', ':help index' },
          { 'tutorial', ':help tutor' },
          { 'summary', ':help summary' },
          { 'quick reference', ':help quickref' },
          { 'search help(F1)', ":lua require('telescope.builtin').help_tags()", 1 },
        },
        {
          'Vim',
          { 'reload vimrc', ':source $MYVIMRC' },
          { 'check health', ':checkhealth' },
          { 'jumps (Alt-j)', ":lua require('telescope.builtin').jumplist()" },
          { 'commands', ":lua require('telescope.builtin').commands()" },
          { 'command history', ":lua require('telescope.builtin').command_history()" },
          { 'registers (A-e)', ":lua require('telescope.builtin').registers()" },
          { 'vim options', ":lua require('telescope.builtin').vim_options()" },
          { 'keymaps', ":lua require('telescope.builtin').keymaps()" },
        },
      }
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
      vim.cmd [[ let test#strategy = "neovim" ]]
    end,
    cmd = { 'TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit' },
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
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        -- auto_close = true,
      }
    end,
    cmd = { 'Trouble', 'TroubleToggle' },
  }

  use {
    'KadoBOT/nvim-spotify',
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require './configs/nvim-spotify'
    end,
    run = 'make',
  }

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

  -- use {
  --   'gukz/ftFT.nvim',
  --   -- This will turn on all functions, if you don't like some of them, add more config to disable/change them
  --   config = function()
  --     vim.g.ftFT_sight_disable = 1 -- if set this, will not have sight line
  --     require('ftFT').setup()
  --   end,
  -- }
  ------------------------------

  ---------- Text Editing ----------
  use { 'rafamadriz/friendly-snippets', event = 'InsertEnter' }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip/loaders/from_vscode').lazy_load()
    end,
    requires = {
      { 'rafamadriz/friendly-snippets' },
      { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
    },
    event = 'InsertEnter',
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require './configs/nvim-cmp'
    end,
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer', event = 'InsertEnter' },
      { 'hrsh7th/cmp-path', event = 'InsertEnter' },
      { 'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter' },
      { 'hrsh7th/cmp-nvim-lua', event = 'InsertEnter' },
    },
    event = 'InsertEnter',
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
      require('catppuccin').setup {
        transparent_background = false,
        term_colors = false,
        styles = {
          comments = 'italic',
          functions = 'italic',
          keywords = 'italic',
          strings = 'NONE',
          variables = 'italic',
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = 'italic',
              hints = 'italic',
              warnings = 'italic',
              information = 'italic',
            },
            underlines = {
              errors = 'underline',
              hints = 'underline',
              warnings = 'underline',
              information = 'underline',
            },
          },
          lsp_trouble = true,
          cmp = true,
          lsp_saga = false,
          gitgutter = false,
          gitsigns = true,
          telescope = true,
          nvimtree = {
            enabled = false,
            show_root = false,
          },
          which_key = true,
          indent_blankline = {
            enabled = false,
            colored_indent_levels = false,
          },
          dashboard = false,
          neogit = false,
          vim_sneak = false,
          fern = false,
          barbar = false,
          bufferline = true,
          markdown = true,
          lightspeed = false,
          ts_rainbow = false,
          hop = false,
          notify = true,
          telekasten = true,
        },
      }
      vim.cmd [[ colorscheme catppuccin ]]
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
