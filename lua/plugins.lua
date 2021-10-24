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

  -- use { 'rmagatti/auto-session', event = 'VimEnter' }

  use { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' }, { 'kyazdani42/nvim-web-devicons' } }

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'configs.telescope'
    end,
    cmd = 'Telescope',
    opt = true,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make', event = 'VimEnter' },
      {
        'camgraff/telescope-tmux.nvim',
        config = function()
          require('telescope').load_extension 'tmux'
        end,
        event = 'VimEnter',
      },
    },
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      -- Example config in Lua
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
      require 'configs.lualine'
    end,
    event = 'UIEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        keymaps = {
          -- Default keymap options
          noremap = true,

          ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
          ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
          ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
          ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
      }
    end,
    event = 'CursorHold',
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
      require 'configs.treesitter'
    end,
    event = 'BufEnter',
    requires = {},
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'configs.autopairs'
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
      require 'configs.nvim-tree'
    end,
    event = 'VimEnter',
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
    event = 'BufEnter',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'configs.null-ls'
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
      require 'configs.cmp'
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
      require 'configs.whichkey'
    end,
    event = 'CursorHold',
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require 'configs.toggleterm'
    end,
    event = 'UIEnter',
  }

  use {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup {
        global_settings = {
          save_on_toggle = false,
          save_on_change = true,
          enter_on_sendcmd = true,
        },
      }
    end,
    event = 'BufRead',
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
      require('mini.surround').setup {
        -- Number of lines within which surrounding is searched
        n_lines = 30,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Pattern to match function name in 'function call' surrounding
        -- By default it is a string of letters, '_' or '.'
        funname_pattern = '[%w_%.]+',

        -- Mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'sa', -- Add surrounding
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`
        },
      }
    end,
  }

  use {
    'romgrk/barbar.nvim',
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '<A-,>', ':BufferPrevious<CR>', opts)
      map('n', '<A-.>', ':BufferNext<CR>', opts)
      -- Re-order to previous/next
      map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
      map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
      -- Goto buffer in position...
      map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
      map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
      map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
      map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
      map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
      map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
      map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
      map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
      map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
      map('n', '<A-0>', ':BufferLast<CR>', opts)
      -- Close buffer
      map('n', '<A-c>', ':BufferClose<CR>', opts)
      map('n', '<leader>c', ':BufferClose<CR>', opts)
      -- Close commands
      --                 :BufferCloseAllButCurrent<CR>
      --                 :BufferCloseBuffersLeft<CR>
      --                 :BufferCloseBuffersRight<CR>
      -- Magic buffer-picking mode
      map('n', '<C-p>', ':BufferPick<CR>', opts)
      map('n', '<leader>C', ':BufferCloseAllButCurrent<CR>', { silent = true, noremap = true })
      -- Sort automatically by...
      -- map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
      -- map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
      -- map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

      -- Set barbar's options
      vim.g.bufferline = {
        -- Enable/disable animations
        animation = true,

        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = false,

        -- Enable/disable current/total tabpages indicator (top right corner)
        tabpages = true,

        -- Enable/disable close button
        closable = false,

        -- Enables/disable clickable tabs
        --  - left-click: go to buffer
        --  - middle-click: delete buffer
        clickable = true,

        -- Excludes buffers from the tabline
        exclude_ft = { 'javascript' },
        exclude_name = { 'package.json' },

        -- Enable/disable icons
        -- if set to 'numbers', will show buffer index in the tabline
        -- if set to 'both', will show buffer index and icons in the tabline
        icons = true,

        -- If set, the icon color will follow its corresponding buffer
        -- highlight group. By default, the Buffer*Icon group is linked to the
        -- Buffer* group (see Highlighting below). Otherwise, it will take its
        -- default value as defined by devicons.
        icon_custom_colors = true,

        -- Configure icons on the bufferline.
        icon_separator_active = '▎',
        icon_separator_inactive = '▎',
        icon_close_tab = '',
        icon_close_tab_modified = '●',
        icon_pinned = '車',

        -- If true, new buffers will be inserted at the start/end of the list.
        -- Default is to insert after current buffer.
        insert_at_end = false,
        insert_at_start = false,

        -- Sets the maximum padding width with which to surround each tab
        maximum_padding = 1,

        -- Sets the maximum buffer name length.
        maximum_length = 30,

        -- If set, the letters for each buffer in buffer-pick mode will be
        -- assigned based on their name. Otherwise or in case all letters are
        -- already assigned, the behavior is to assign letters in order of
        -- usability (see order below)
        semantic_letters = true,

        -- New buffer letters are assigned in this order. This order is
        -- optimal for the qwerty keyboard layout but might need adjustement
        -- for other layouts.
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

        -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
        -- where X is the buffer number. But only a static string is accepted here.
        no_name_title = nil,
      }
    end,
    event = 'BufEnter',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
end)
