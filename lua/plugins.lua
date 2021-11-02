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
    { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
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
      {
        'camgraff/telescope-tmux.nvim',
        config = function()
          require('telescope').load_extension 'tmux'
        end,
      },
      { 'nvim-treesitter/playground' },
    },
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }

      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      vim.g.tokyonight_colors = { hint = 'orange', error = '#ff0000' }
      vim.cmd [[colorscheme tokyonight]]
    end,
    after = 'lualine.nvim',
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require './configs/lualine'
    end,
    event = 'UIEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require './configs/gitsigns'
    end,
    event = 'BufRead',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        {
          ---@param ctx Ctx
          pre_hook = function(ctx)
            return require('ts_context_commentstring.internal').calculate_commentstring()
          end,
        },
      }
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
    event = 'BufEnter',
    requires = {
      {
        'code-biscuits/nvim-biscuits',
        config = function()
          require('nvim-biscuits').setup {}
        end,
        after = 'nvim-treesitter',
      },
      {
        'nvim-treesitter/playground',
      },
    },
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
    ft = { 'js', 'css', 'html', 'vue', 'lua' },
    after = 'nvim-treesitter',
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require './configs/nvim-tree'
    end,
    cmd = 'NvimTreeToggle',
    opt = true,
    requires = { 'kyazdani42/nvim-web-devicons' },
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
    event = 'BufReadPre',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
  }

  -- Auto Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require './configs/cmp'
    end,
    requires = {
      'hrsh7th/cmp-buffer',
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
        requires = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
      },
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
    event = 'BufEnter',
    requires = { 'popup.nvim', 'plenary.nvim' },
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
      require('rest-nvim').setup {
        result_split_horizontal = false,
        skip_ssl_verification = false,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        jump_to_request = true,
      }
      vim.api.nvim_set_keymap('n', 'Q', "<cmd>lua require'rest-nvim'.run()<CR>", { silent = true, noremap = true })
    end,
    ft = { 'http' },
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'akinsho/flutter-tools.nvim',
    config = function()
      require('flutter-tools').setup {}
    end,
    ft = { 'dart' },
    requires = 'nvim-lua/plenary.nvim',
  }

  use {
    'chentau/marks.nvim',
    config = function()
      require('marks').setup {
        default_mappings = true, -- whether to map keybinds or not. default true
        builtin_marks = { '.', '<', '>', '^' }, -- which builtin marks to show. default {}
        cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
        force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
        -- bookmark_0 = { -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own sign/virttext
        --   sign = '⚑',
        --   virt_text = 'hello world',
        -- },
        mappings = {},
      }
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
    event = 'BufRead',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- TESTING
  use {
    'TimUntersberger/neogit',
    config = function()
      local neogit = require 'neogit'

      neogit.setup {
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        auto_refresh = true,
        disable_builtin_notifications = false,
        commit_popup = {
          kind = 'split',
        },
        -- Change the default way of opening neogit
        kind = 'tab',
        -- customize displayed signs
        signs = {
          -- { CLOSED, OPENED }
          section = { '>', 'v' },
          item = { '>', 'v' },
          hunk = { '', '' },
        },
        integrations = {
          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
          -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
          --
          -- Requires you to have `sindrets/diffview.nvim` installed.
          -- use {
          --   'TimUntersberger/neogit',
          --   requires = {
          --     'nvim-lua/plenary.nvim',
          --     'sindrets/diffview.nvim'
          --   }
          -- }
          --
          diffview = false,
        },
        -- override/add mappings
        mappings = {
          -- modify status buffer mappings
          status = {},
        },
      }
    end,
    cmd = 'Neogit',
    opt = true,
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      vim.cmd [[ let g:db_ui_auto_execute_table_helpers = 1 ]]
      vim.api.nvim_set_keymap('n', 'gj', '<cmd>DBUI<CR>', { noremap = true, silent = true })
    end,
    requires = {
      { 'tpope/vim-dadbod' },
      {
        'kristijanhusak/vim-dadbod-completion',
        config = function()
          vim.cmd [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
        end,
        event = 'BufRead',
      },
    },
    event = 'BufRead',
  }

  -- use {
  --   'github/copilot.vim',
  -- }

  -- use {
  --   'kevinhwang91/nvim-bqf',
  --   config = function()
  --     require('bqf').setup {
  --       auto_enable = {
  --         description = [[enable nvim-bqf in quickfix window automatically]],
  --         default = true,
  --       },
  --       magic_window = {
  --         description = [[give the window magic, when the window is splited horizontally, keep
  --           the distance between the current line and the top/bottom border of neovim unchanged.
  --           It's a bit like a floating window, but the window is indeed a normal window, without
  --           any floating attributes.]],
  --         default = true,
  --       },
  --       auto_resize_height = {
  --         description = [[resize quickfix window height automatically.
  --           Shrink higher height to size of list in quickfix window, otherwise extend height
  --           to size of list or to default height (10)]],
  --         default = true,
  --       },
  --       preview = {
  --         auto_preview = {
  --           description = [[enable preview in quickfix window automatically]],
  --           default = true,
  --         },
  --         border_chars = {
  --           description = [[border and scroll bar chars, they respectively represent:
  --               vline, vline, hline, hline, ulcorner, urcorner, blcorner, brcorner, sbar]],
  --           default = { '│', '│', '─', '─', '╭', '╮', '╰', '╯', '█' },
  --         },
  --         delay_syntax = {
  --           description = [[delay time, to do syntax for previewed buffer, unit is millisecond]],
  --           default = 50,
  --         },
  --         win_height = {
  --           description = [[the height of preview window for horizontal layout]],
  --           default = 15,
  --         },
  --         win_vheight = {
  --           description = [[the height of preview window for vertical layout]],
  --           default = 15,
  --         },
  --         wrap = {
  --           description = [[wrap the line, `:h wrap` for detail]],
  --           default = false,
  --         },
  --         should_preview_cb = {
  --           description = [[a callback function to decide whether to preview while switching buffer,
  --               with a bufnr parameter]],
  --           default = nil,
  --         },
  --       },
  --       func_map = {
  --         description = [[the table for {function = key}]],
  --         default = [[see ###Function table for detail]],
  --       },
  --       filter = {
  --         fzf = {
  --           action_for = {
  --             ['ctrl-t'] = {
  --               description = [[press ctrl-t to open up the item in a new tab]],
  --               default = 'tabedit',
  --             },
  --             ['ctrl-v'] = {
  --               description = [[press ctrl-v to open up the item in a new vertical split]],
  --               default = 'vsplit',
  --             },
  --             ['ctrl-x'] = {
  --               description = [[press ctrl-x to open up the item in a new horizontal split]],
  --               default = 'split',
  --             },
  --             ['ctrl-q'] = {
  --               description = [[press ctrl-q to toggle sign for the selected items]],
  --               default = 'signtoggle',
  --             },
  --           },
  --           extra_opts = {
  --             description = 'extra options for fzf',
  --             default = { '--bind', 'ctrl-o:toggle-all' },
  --           },
  --         },
  --       },
  --     }
  --   end,
  --   event = 'VimEnter',
  -- }
end)
