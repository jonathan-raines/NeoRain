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

  -- Finders
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup {
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          layout_config = {
            height = 0.9,
            preview_width = 80,
            width = 0.9,
          },
          mappings = {
            i = {},
          },
          pickers = {
            find_files = {
              hidden = true,
            },
          }
        },
      }
      --Add leader shortcuts
      -- vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
    end,
    event = "UIEnter",
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use {
    'camspiers/snap',
    config = function ()
      local snap = require "snap"
      local fzf = snap.get "consumer.fzf"
      local limit = snap.get "consumer.limit"
      local producer_file = snap.get"producer.ripgrep.file".args {
          '--hidden', "--iglob", "!vendor/* !node_modules/* !target/* !git/*"
      }
      local producer_vimgrep = snap.get "producer.ripgrep.vimgrep"
      local producer_buffer = snap.get "producer.vim.buffer"
      local producer_oldfile = snap.get "producer.vim.oldfile"
      local producer_git = snap.get "consumer.fzf"(snap.get "producer.git.file")
      local select_file = snap.get "select.file"
      local select_vimgrep = snap.get "select.vimgrep"
      local preview_file = snap.get "preview.file"
      local preview_vimgrep = snap.get "preview.vimgrep"

      function SnapFiles()
        snap.run({
          prompt = "  Files  ",
          producer = fzf(producer_file),
          select = select_file.select,
          multiselect = select_vimgrep.multiselect,
          views = {preview_file}
        })
      end

      function SnapGrep()
        snap.run({
          prompt = "  Grep  ",
          producer = limit(10000, producer_vimgrep),
          select = select_vimgrep.select,
          multiselect = select_vimgrep.multiselect,
          views = {preview_vimgrep}
        })
      end

      function SnapGrepSelectedWord()
        snap.run({
          prompt = "  Grep  ",
          producer = limit(10000, producer_vimgrep),
          select = select_vimgrep.select,
          multiselect = select_vimgrep.multiselect,
          views = {preview_vimgrep},
          initial_filter = vim.fn.expand("<cword>")
        })
      end

      function SnapGit()
        snap.run {
          prompt = "  Git  ",
          producer = producer_git,
          select = select_file.select,
          multiselect = select_file.multiselect,
          views = {preview_file}
        }
      end

      function SnapBuffers()
        snap.run({
          prompt = " ﬘ Buffers  ",
          producer = fzf(producer_buffer),
          select = select_file.select,
          multiselect = select_file.multiselect,
          views = {preview_file}
        })
      end

      function SnapOldFiles()
        snap.run({
          prompt = "  Oldfiles  ",
          producer = fzf(producer_oldfile),
          select = select_file.select,
          multiselect = select_file.multiselect,
          views = {preview_file}
        })
      end
      vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua SnapBuffers()<CR>", {noremap = true, silent = true})
    end,
    after = 'which-key.nvim'
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
    event = 'BufReadPre',
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
    event = "BufReadPre"
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      local border = { "─", "│", "─", "│", "┌", "┐", "┘", "└" } -- { "", "", "", " ", "", "", "", " " }

      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        ignore_installed = {'haskell'},
        autopairs = { enable = true },
        autotag = {enable = true},
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        indent = {
          enable = true,
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        textobjects = {
          lsp_interop = {
            enable = true,
            border = border,
            peek_definition_code = {
              ['gp'] = '@function.outer'
            }
          },
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['ai'] = '@conditional.outer',
              ['ii'] = '@conditional.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
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
          swap = {
            enable = true,
            swap_next = {
              ['glc'] = '@class.outer',
              ['glf'] = '@function.outer',
              ['glp'] = '@parameter.inner',
            },
           swap_previous = {
              ['ghc'] = "@class.outer",
              ['ghf'] = "@function.outer",
              ['ghp'] = "@parameter.inner",
            },
          },
        },
      }
    end,
    event = "BufRead"
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = {'string'},-- it will not add pair on that treesitter node
          javascript = {'template_string'},
          java = false,-- don't check treesitter on java
        }
      })

      local ts_conds = require('nvim-autopairs.ts-conds')

      -- press % => %% is only inside comment or string
      npairs.add_rules({
        Rule("%", "%", "lua")
          :with_pair(ts_conds.is_ts_node({'string','comment'})),
        Rule("$", "$", "lua")
          :with_pair(ts_conds.is_not_ts_node({'function'}))
      })
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
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter'
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function ()
      vim.g.nvim_tree_quit_on_open = 1
      vim.g.nvim_tree_disable_netrw = 0
      vim.g.nvim_tree_hide_dotfiles = 1
      vim.g.nvim_tree_indent_markers = 0
      vim.g.nvim_tree_follow = 1
      vim.g.nvim_tree_lsp_diagnostics = 0
      vim.g.nvim_tree_auto_close = 1
      vim.g.nvim_tree_auto_ignore_ft = {"startify", "dashboard"}
      vim.g.nvim_tree_show_icons = {
          git = 1,
          folders = 1,
          files = 1,
          folder_arrows = 0
      }
      vim.g.nvim_tree_icons = {
          default = "",
          symlink = "",
          git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              ignored = "◌"
          },
          folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = ""
          }
      }
    end,
    event = "UIEnter",
    requires = { 'kyazdani42/nvim-web-devicons' } }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function ()
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.formatting.eslint_d.with({
          condition = function(utils)
              return utils.root_has_file(".eslintrc.js")
          end,
        }),
        null_ls.builtins.diagnostics.eslint_d,
      }
      require("null-ls").config({
          sources = sources
      })

      require("lspconfig")["null-ls"].setup({
        on_attach = function()
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
      })
    end,
    event = 'BufRead',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' } }
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim' },
    ft = { 'js', 'vue' }
  }

  -- Auto Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function ()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local luasnip = require 'luasnip'

      local function t(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local check_back_space = function()
        local col = vim.fn.col '.' - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
      end

      cmp.setup {
        formatting = {
            format = function(_, vim_item)
              vim_item.menu = lspkind.presets.default[vim_item.kind]
            return vim_item
          end
        },

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<tab>"] = cmp.mapping(function(fallback)
              if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-n>"), "n")
              elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
              elseif check_back_space() then
                vim.fn.feedkeys(t("<tab>"), "n")
              else
                fallback()
              end
            end, {
              "i",
              "s",
            }),
            ["<S-tab>"] = cmp.mapping(function(fallback)
              if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-p>"), "n")
              elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
              else
                fallback()
              end
            end, {
              "i",
              "s",
            }),
        },

        sources = {
          { name = 'buffer' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
      }
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
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp'
    }
  }

  use {
    'folke/which-key.nvim',
    config = function ()
      require('which-key').setup{
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          presets = {
              operators = false, -- adds help for operators like d, y, ...
              motions = false, -- adds help for motions
              text_objects = true, -- help for text objects triggered after entering an operator
              windows = false, -- default bindings on <c-w>
              nav = true, -- misc bindings to work with windows
              z = true, -- bindings for folds, spelling and others prefixed with z
              g = true -- bindings for prefixed with g
          }
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+" -- symbol prepended to a group
        },
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
            padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
        },
        layout = {
            height = {min = 4, max = 25}, -- min and max height of the columns
            width = {min = 20, max = 50}, -- min and max width of the columns
            spacing = 3 -- spacing between columns
        },
        hidden = {"<silent>", "<cmd>", "<cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
        show_help = true -- show help message on the command line when the popup is visible
      }

      local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false -- use `nowait` when creating keymaps
      }

      -- explorer
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<leader><space>', '<C-^>', {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<A-i>', ':ToggleTerm<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('t', '<A-i>', '<ESC>:ToggleTerm<CR>', {noremap = true, silent = true})

      -- Buffers
      vim.api.nvim_set_keymap("n", "<leader>c", ":bdelete<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>C", "<cmd>BufOnly<CR>", {noremap = true, silent = true})

      vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>q", ":q!<CR>", {noremap = true, silent = true})

      local mappings = {
        ["/"] = "Comment",
        ['<space>'] = 'Switch to Last Buffer',
        ["e"] = "Explorer",
        ["b"] = "Buffers",
        ["w"] = "Save",
        ["c"] = "Close Buffer",
        ["C"] = "Close All Except Current Buffer",
        ["q"] = "Quit",
        d = {
          name = 'Diagnostics',
          ga = {"<cmd>lua vim.lsp.diagnostic.get_all()<cr>", "Get All"},
          gn = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Get Next"},
          gp = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Get Previous"},
          ld = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Show Line Diagnostics"},
        },
        f = {
          name = "+Find",
          -- b = {"<cmd>Telescope buffers<cr>", "Open buffers"},
          -- c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
          -- ds = {"<cmd>Telescope lsp_document_symbols<cr>", "Colorscheme"},
          e = {"<cmd>Telescope file_browser<cr>", "File Browser"},
          x = {"<cmd> Telescope find_files<CR>", "Find Files"},
          b = {"<cmd>lua SnapBuffers()<CR>", "Find Files"},
          f = {"<cmd>lua SnapFiles()<CR>", "Find Files"},
          w = {"<cmd>lua SnapGrep()<CR>", "Find Word"},
          g = {"<cmd>lua SnapGit()<CR>", "Find Git"},
          sw = {"<cmd>lua SnapGrepSelectedWord()<CR>", "Find Selected Word"},
          of = {"<cmd>lua SnapOldFiles()<CR>", "Find Old Files"},
          -- i = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Current Buffer"},
          -- km = {"<cmd>Telescope keymaps<cr>", "Find Keymaps"},
          -- m = {"<cmd>Telescope marks<cr>", "Marks"},
          -- p = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
          -- of = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
          -- ts = {"<cmd>Telescope treesitter<cr>", "Treesitter"},
          -- td = {"<cmd>TodoTelescope<cr>", "Find TODO's"},
          -- vo = {"<cmd>Telescope vim_options<cr>", "Find Vim Options"},
          -- gs = {"<cmd>Telescope grep_string<cr>", "Grep String"},
          -- ws = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workplace Symbols"},
        },
        g = {
          name = "+Git",
          nh = {"<cmd>lua require'gitsigns'.next_hunk()<cr>", "Next Hunk"},
          ph = {"<cmd>lua require'gitsigns'.prev_hunk()<cr>", "Previous Hunk"},
          sh = {"<cmd>lua require'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
          ush = {"<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>", "Unstage Hunk"},
          rh = {"<cmd>lua require'gitsigns'.reset_hunk()<cr>", "Reset Hunk"},
          rb = {"<cmd>lua require'gitsigns'.reset_buffer()<cr>", "Reset Buffer"},
          pvh = {"<cmd>lua require'gitsigns'.preview_hunk()<cr>", "Preview Hunk"},
          b = {"<cmd>lua require'gitsigns'.blame_line()<cr>", "Blame Line"},
        },
        l = {
          name = "+LSP",
          a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
          i = {"<cmd>LspInfo<cr>", "Info"},
          f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "LSP Finder"},
          r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
          t = {"<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition"},
        },
      }

      local wk = require("which-key")
      wk.register(mappings, opts)
    end,
    event = "VimEnter"
  }
  use {
    'ahmedkhalf/project.nvim',
    config = function ()
      require('project_nvim').setup{
        ignore_lsp = { 'solargraph' },
        show_hidden = true,
      }
    end,
    event = 'BufEnter'
  }
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function ()
      require("toggleterm").setup{
        -- size can be a number or function which is passed the current terminal
        size = 20 or function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = 'curved',
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          }
        }
      }

      function _G.set_terminal_keymaps()
        local opts = {noremap = true}
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal  = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
      local term = Terminal:new({ hidden = true, direction = 'horizontal' })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      function _normterm_toggle()
        term:toggle()
      end

      vim.api.nvim_set_keymap("n", "<A-l>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("t", "<A-l>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

      vim.api.nvim_set_keymap("n", "<A-i>", "<cmd>lua _normterm_toggle()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("t", "<A-i>", "<cmd>lua _normterm_toggle()<CR>", {noremap = true, silent = true})
    end,
    event = 'VimEnter'
  }
end)
