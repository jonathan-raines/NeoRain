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
  use {"folke/trouble.nvim", opt = true}
  -- LSP Require
  require_plugin("nvim-lspconfig")
  require_plugin("nvim-lspinstall")
  require_plugin("lspsaga.nvim")
  require_plugin("trouble.nvim")

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

  -- Nvim-Tree
  use {"kyazdani42/nvim-tree.lua", opt = true}
  use {"kyazdani42/nvim-web-devicons", opt = true}
  -- Nvim-Tree Require
  require_plugin("nvim-tree.lua")
  require_plugin("nvim-web-devicons")

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

  -- Git
  use {"lewis6991/gitsigns.nvim", opt = true }
  use {"f-person/git-blame.nvim", opt = true }
  use {"kdheepak/lazygit.nvim", opt = true}
  -- Git Require
  require_plugin("gitsigns.nvim")
  require_plugin("git-blame.nvim")
  require_plugin("lazygit.nvim")

  -- Keybindings
  use {"folke/which-key.nvim", opt = true}
  -- Keybindings Require
  require_plugin("which-key.nvim")

  -- AutoPairs
  use {"windwp/nvim-autopairs", opt = true}
  require_plugin("nvim-autopairs")

  -- Formatting
  use {"tpope/vim-surround", opt = true}
  require_plugin("vim-surround")

  -- Comments
  use {"terrortylor/nvim-comment", opt = true}
  use {"JoosepAlviste/nvim-ts-context-commentstring", opt = true}
  use {"folke/todo-comments.nvim", opt = true}
  require_plugin("nvim-comment")
  require_plugin("nvim-ts-context-commentstring")
  require_plugin("todo-comments.nvim")

  -- Barbar / Galaxy Line
  use {"glepnir/galaxyline.nvim", opt = true}
  use {"romgrk/barbar.nvim", opt = true}
  require_plugin("galaxyline.nvim")
  require_plugin("barbar.nvim")

  -- Themes
  use {"navarasu/onedark.nvim", opt = true}
  require_plugin("onedark.nvim")
  use {"folke/tokyonight.nvim", opt = true}
  require_plugin("tokyonight.nvim")
  use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}
  require_plugin("nvcode-color-schemes")

  use {"norcalli/nvim-colorizer.lua", opt = true}
  use {"simrat39/symbols-outline.nvim", opt = true}
  require_plugin("nvim-colorizer.lua")
  require_plugin("symbols-outline")

end)
