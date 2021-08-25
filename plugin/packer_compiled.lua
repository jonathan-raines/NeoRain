-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jraines/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/jraines/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/jraines/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/jraines/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jraines/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2¯\2\0\0\4\0\16\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\14\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\2:\2\15\1>\0\2\1G\0\1\0\nsigns\1\0\0\17changedelete\1\0\2\ttext\6~\ahl\20GitGutterChange\14topdelete\1\0\2\ttext\bâ€¾\ahl\20GitGutterDelete\vdelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\vchange\1\0\2\ttext\6~\ahl\20GitGutterChange\badd\1\0\0\1\0\2\ttext\6+\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2®\3\0\0\t\0\20\1.4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\2\3\0003\3\4\0003\4\6\0003\5\5\0:\5\a\0043\5\b\0:\5\t\4:\4\n\3>\2\2\0014\2\0\0%\3\v\0>\2\2\0027\3\f\0002\4\3\0\16\5\1\0%\6\r\0%\a\r\0%\b\a\0>\5\4\2\16\6\5\0007\5\14\0057\a\15\0023\b\16\0>\a\2\0=\5\1\2;\5\1\4\16\5\1\0%\6\17\0%\a\17\0%\b\a\0>\5\4\2\16\6\5\0007\5\14\0057\a\18\0023\b\19\0>\a\2\0=\5\1\0<\5\0\0>\3\2\1G\0\1\0\1\2\0\0\rfunction\19is_not_ts_node\6$\1\3\0\0\vstring\fcomment\15is_ts_node\14with_pair\6%\14add_rules\28nvim-autopairs.ts-conds\14ts_config\15javascript\1\2\0\0\20template_string\blua\1\0\1\tjava\1\1\2\0\0\vstring\1\0\1\rcheck_ts\2\nsetup\24nvim-autopairs.rule\19nvim-autopairs\frequire\5€€À™\4\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\1\2§\1\0\0\3\0\b\0\0144\0\0\0007\0\1\0007\0\2\0'\1\0\0%\2\3\0>\0\3\2\a\0\4\0T\0\5€4\0\5\0%\1\6\0>\0\2\0027\0\a\0>\0\1\1G\0\1\0\25update_commentstring&ts_context_commentstring.internal\frequire\bvue\rfiletype\24nvim_buf_get_option\bapi\bvimÿ\1\1\0\5\0\15\0\0254\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0001\2\4\0:\2\5\1>\0\2\0014\0\6\0007\0\a\0007\0\b\0%\1\t\0%\2\n\0%\3\v\0003\4\f\0>\0\5\0014\0\6\0007\0\a\0007\0\b\0%\1\r\0%\2\n\0%\3\v\0003\4\14\0>\0\5\1G\0\1\0\1\0\2\vsilent\2\fnoremap\2\6v\1\0\2\vsilent\2\fnoremap\2\23:CommentToggle<CR>\14<leader>/\6n\20nvim_set_keymap\bapi\bvim\thook\0\1\0\1\18comment_empty\1\nsetup\17nvim_comment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  snap = {
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/snap"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\2¥\2\0\0\5\0\17\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\15\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0002\4\0\0:\4\t\3:\3\n\0023\3\f\0003\4\v\0:\4\r\3:\3\14\2:\2\16\1>\0\2\1G\0\1\0\rdefaults\1\0\0\fpickers\15find_files\1\0\0\1\0\1\vhidden\2\rmappings\6i\1\0\0\18layout_config\1\0\3\18preview_width\3P\vheight\4Í™³æ\fÌ™³ÿ\3\nwidth\4Í™³æ\fÌ™³ÿ\3\16borderchars\1\0\0\1\t\0\0\bâ”€\bâ”‚\bâ”€\bâ”‚\bâ”Œ\bâ”\bâ”˜\bâ””\nsetup\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\1\2c\0\0\2\0\6\0\t4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\4\0%\1\5\0>\0\2\1G\0\1\0\27colorscheme tokyonight\bcmd\nnight\21tokyonight_style\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'gitsigns.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs', 'nvim-comment'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'tokyonight.nvim', 'telescope.nvim', 'snap'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
