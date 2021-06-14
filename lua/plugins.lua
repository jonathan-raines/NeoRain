local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd("packadd " .. plugin) end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {"windwp/nvim-ts-autotag", opt = true}
  use {'andymass/vim-matchup', opt = true}
  -- Treesitter Require
  require_plugin("nvim-ts-autotag")
  require_plugin("vim-matchup")

  -- LSP
  use { 'neovim/nvim-lspconfig', opt = true }
  use { 'kabouzeid/nvim-lspinstall', opt = true }
  use { 'glepnir/lspsaga.nvim', opt = true }
  -- LSP Require
  require_plugin("nvim-lspconfig")
  require_plugin("nvim-lspinstall")
  require_plugin("lspsaga.nvim")

  -- Telescope
  use {"nvim-lua/popup.nvim", opt = true}
  use {"nvim-lua/plenary.nvim", opt = true}
  use {"nvim-telescope/telescope.nvim", opt = true}
  use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
  use {"nvim-telescope/telescope-project.nvim", opt = true}
  -- Telescope Require
  require_plugin("popup.nvim")
  require_plugin("plenary.nvim")
  require_plugin("telescope.nvim")
  require_plugin("telescope-fzy-native.nvim")
  require_plugin("telescope-project.nvim")

  -- Debugging
  use {"mfussenegger/nvim-dap", opt = true}
  -- Debugging Require
  require_plugin("nvim-dap")

  -- Autocomplete
  use {"hrsh7th/nvim-compe", opt = true}
  use {"hrsh7th/vim-vsnip", opt = true}
  use {"rafamadriz/friendly-snippets", opt = true}
  -- Autocomplete Require
  require_plugin("nvim-compe")
  require_plugin("vim-vsnip")
  require_plugin("friendly-snippets")
end)
