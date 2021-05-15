local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
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
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"

	-- LSP
	use {"neovim/nvim-lspconfig", opt = true}
	use {"kabouzeid/nvim-lspinstall", opt = true}

	use {"hrsh7th/nvim-compe", opt = true}

	use {"tpope/vim-surround", opt = true}
	use "tpope/vim-endwise"
	use "folke/tokyonight.nvim"

	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	-- use {"windwp/nvim-ts-autotag", opt = true} -- use treesitter to autoclose html tags
	
        use {"kyazdani42/nvim-tree.lua", opt = true}
	use {"kyazdani42/nvim-web-devicons", opt = true}


	require_plugin("vim-surround")

	require_plugin("nvim-lspconfig")
	require_plugin("kabouzeid/nvim-lspinstall")
	
	require_plugin("nvim-compe")

	require_plugin("nvim-tree.lua")
	require_plugin("nvim-web-devicons")
    end
)
