local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "plugin", "packer_compiled.vim"),
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Treesitter
  use { 
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = "BufRead" ,
    config = function() require "nr-treesitter" end
  }
  use {"windwp/nvim-ts-autotag", after = "nvim-treesitter"}
  use {"JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter"}
  use {"windwp/nvim-autopairs", after = "nvim-treesitter", config = function() require "nr-autopairs" end}

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    event = "BufWinEnter",
    config = function() require "lsp" end
  }
  use { 
    'kabouzeid/nvim-lspinstall', 
    config = function() require'lspinstall'.setup() end,
    event = "BufEnter"
  }
  use { "ray-x/lsp_signature.nvim", 
        config = function() require"lsp_signature".on_attach() end,
        event = "InsertEnter" 
      }

  -- Telescope
  use {'nvim-telescope/telescope.nvim',
    event = "BufEnter",
    config = function() require("nr-telescope.init").setup() end,
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  }

  -- Nvim-Tree
  use {"kyazdani42/nvim-web-devicons", event = "BufWinEnter"}
  use {"romgrk/barbar.nvim", after = "nvim-web-devicons"}
  use {"kyazdani42/nvim-tree.lua", after = "nvim-web-devicons"}

  -- Autocomplete
  use {"hrsh7th/nvim-compe", event = "InsertEnter", config = function() require "nr-compe" end}
  use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
  use {"rafamadriz/friendly-snippets", event = "InsertEnter"}
  -- use {"Neevash/awesome-flutter-snippets"}

  -- Git
  use {"lewis6991/gitsigns.nvim", event = "InsertEnter", config = function() require "nr-gitsigns" end }
  use {"folke/which-key.nvim", event = "BufWinEnter", config = function() require "nr-which-key" end}

  -- Comments
  use {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
        require("nvim_comment").setup({
            comment_empty = false
        })
    end
  }

  -- Barbar / Galaxy Line
  use {
      "glepnir/galaxyline.nvim",
      event = "BufWinEnter",
      config = function() require "nr-galaxy-line" end
  }

  -- Themes
  use {
    "folke/tokyonight.nvim",
    event = "BufWinEnter",
    config = function() require "theme" end
  }
end)
