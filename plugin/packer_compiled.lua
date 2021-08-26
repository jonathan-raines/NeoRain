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
    config = { "\27LJ\1\2Ø\2\0\0\4\0\16\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\14\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\2:\2\15\1>\0\2\1G\0\1\0\nsigns\1\0\0\17changedelete\1\0\2\ttext\6~\ahl\20GitGutterChange\14topdelete\1\0\2\ttext\b‚Äæ\ahl\20GitGutterDelete\vdelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\vchange\1\0\2\ttext\6~\ahl\20GitGutterChange\badd\1\0\0\1\0\2\ttext\6+\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\flualine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    config = { '\27LJ\1\2.\0\1\3\0\2\0\0037\1\0\0%\2\1\0@\1\2\0\17.eslintrc.js\18root_has_fileä\2\1\0\5\0\17\0"4\0\0\0%\1\1\0>\0\2\0022\1\3\0007\2\2\0007\2\3\0027\2\4\0027\2\5\0023\3\a\0001\4\6\0:\4\b\3>\2\2\2;\2\1\0017\2\2\0007\2\t\0027\2\4\2;\2\2\0014\2\0\0%\3\1\0>\2\2\0027\2\n\0023\3\v\0:\1\f\3>\2\2\0014\2\0\0%\3\r\0>\2\2\0027\2\1\0027\2\14\0023\3\15\0004\4\16\0:\4\16\3>\2\2\1G\0\1\0\14on_attach\1\0\0\nsetup\14lspconfig\fsources\1\0\0\vconfig\16diagnostics\14condition\1\0\0\0\twith\reslint_d\15formatting\rbuiltins\fnull-ls\frequire\0' },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2Æ\3\0\0\t\0\20\1.4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\2\3\0003\3\4\0003\4\6\0003\5\5\0:\5\a\0043\5\b\0:\5\t\4:\4\n\3>\2\2\0014\2\0\0%\3\v\0>\2\2\0027\3\f\0002\4\3\0\16\5\1\0%\6\r\0%\a\r\0%\b\a\0>\5\4\2\16\6\5\0007\5\14\0057\a\15\0023\b\16\0>\a\2\0=\5\1\2;\5\1\4\16\5\1\0%\6\17\0%\a\17\0%\b\a\0>\5\4\2\16\6\5\0007\5\14\0057\a\18\0023\b\19\0>\a\2\0=\5\1\0<\5\0\0>\3\2\1G\0\1\0\1\2\0\0\rfunction\19is_not_ts_node\6$\1\3\0\0\vstring\fcomment\15is_ts_node\14with_pair\6%\14add_rules\28nvim-autopairs.ts-conds\14ts_config\15javascript\1\2\0\0\20template_string\blua\1\0\1\tjava\1\1\2\0\0\vstring\1\0\1\rcheck_ts\2\nsetup\24nvim-autopairs.rule\19nvim-autopairs\frequire\5ÄÄ¿ô\4\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\1\2F\0\1\6\0\3\0\b4\1\0\0007\1\1\0017\1\2\1\16\2\0\0)\3\2\0)\4\2\0)\5\2\0@\1\5\0\27nvim_replace_termcodes\bapi\bvimõ\1\0\0\5\0\b\2\0284\0\0\0007\0\1\0007\0\2\0%\1\3\0>\0\2\2\21\0\0\0\b\0\1\0T\1\18Ä4\1\0\0007\1\1\0017\1\4\1%\2\3\0>\1\2\2\16\2\1\0007\1\5\1\16\3\0\0\16\4\0\0>\1\4\2\16\2\1\0007\1\6\1%\3\a\0>\1\3\2\v\1\0\0T\1\2Ä)\1\1\0T\2\1Ä)\1\2\0H\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0?\0\2\4\1\4\0\a+\2\0\0007\2\1\0027\2\2\0027\3\3\0016\2\3\2:\2\0\1H\1\2\0\1¿\tkind\fdefault\fpresets\tmenuC\0\1\3\0\4\0\a4\1\0\0%\2\1\0>\1\2\0027\1\2\0017\2\3\0>\1\2\1G\0\1\0\tbody\15lsp_expand\fluasnip\frequireú\2\0\1\4\3\n\1-4\1\0\0007\1\1\0017\1\2\1>\1\1\2\t\1\0\0T\1\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\4\0>\2\2\2%\3\5\0>\1\3\1T\1\29Ä+\1\1\0007\1\6\1>\1\1\2\15\0\1\0T\2\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\a\0>\2\2\2%\3\b\0>\1\3\1T\1\15Ä+\1\2\0>\1\1\2\15\0\1\0T\2\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\t\0>\2\2\2%\3\5\0>\1\3\1T\1\2Ä\16\1\0\0>\1\1\1G\0\1\0\3¿\2¿\4¿\n<tab>\5!<Plug>luasnip-expand-or-jump\23expand_or_jumpable\6n\n<C-n>\rfeedkeys\15pumvisible\afn\bvim\2’\1\0\1\4\2\t\1!4\1\0\0007\1\1\0017\1\2\1>\1\1\2\t\1\0\0T\1\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\4\0>\2\2\2%\3\5\0>\1\3\1T\1\17Ä+\1\1\0007\1\6\1'\2ˇˇ>\1\2\2\15\0\1\0T\2\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\a\0>\2\2\2%\3\b\0>\1\3\1T\1\2Ä\16\1\0\0>\1\1\1G\0\1\0\3¿\2¿\5\28<Plug>luasnip-jump-prev\rjumpable\6n\n<C-p>\rfeedkeys\15pumvisible\afn\bvim\2¡\4\1\0\v\0)\0B4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\0\0%\3\3\0>\2\2\0021\3\4\0001\4\5\0007\5\6\0003\6\n\0003\a\b\0001\b\a\0:\b\t\a:\a\v\0063\a\r\0001\b\f\0:\b\14\a:\a\15\0063\a\18\0007\b\16\0007\b\17\b>\b\1\2:\b\19\a7\b\16\0007\b\20\b>\b\1\2:\b\21\a7\b\16\0007\b\22\b>\b\1\2:\b\23\a7\b\16\0007\b\24\b3\t\27\0007\n\25\0007\n\26\n:\n\28\t>\b\2\2:\b\29\a7\b\16\0001\t\30\0003\n\31\0>\b\3\2:\b \a7\b\16\0001\t!\0003\n\"\0>\b\3\2:\b#\a:\a\16\0062\a\5\0003\b$\0;\b\1\a3\b%\0;\b\2\a3\b&\0;\b\3\a3\b'\0;\b\4\a:\a(\6>\5\2\0010\0\0ÄG\0\1\0\fsources\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\f<S-tab>\1\3\0\0\6i\6s\0\n<tab>\1\3\0\0\6i\6s\0\t<CR>\rbehavior\1\0\1\vselect\2\vInsert\20ConfirmBehavior\fconfirm\n<C-e>\nclose\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\15formatting\1\0\0\vformat\1\0\0\0\nsetup\0\0\fluasnip\flspkind\bcmp\frequire\0" },
    loaded = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\1\2^\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\25update_commentstring&ts_context_commentstring.internal\frequireˇ\1\1\0\5\0\15\0\0254\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0001\2\4\0:\2\5\1>\0\2\0014\0\6\0007\0\a\0007\0\b\0%\1\t\0%\2\n\0%\3\v\0003\4\f\0>\0\5\0014\0\6\0007\0\a\0007\0\b\0%\1\r\0%\2\n\0%\3\v\0003\4\14\0>\0\5\1G\0\1\0\1\0\2\vsilent\2\fnoremap\2\6v\1\0\2\vsilent\2\fnoremap\2\23:CommentToggle<CR>\14<leader>/\6n\20nvim_set_keymap\bapi\bvim\thook\0\1\0\1\18comment_empty\1\nsetup\17nvim_comment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-lsp-ts-utils"
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
    config = { "\27LJ\1\2y\0\1\2\0\6\1\0157\1\0\0\a\1\1\0T\1\3Ä'\1\15\0H\1\2\0T\1\bÄ7\1\0\0\a\1\2\0T\1\5Ä4\1\3\0007\1\4\0017\1\5\1\22\1\0\1H\1\2\0G\0\1\0\fcolumns\6o\bvim\rvertical\15horizontal\14directionµÊÃô\19ô≥Ê˛\3Å\3\0\0\a\0\16\00083\0\0\0004\1\1\0007\1\2\0017\1\3\1'\2\0\0%\3\4\0%\4\5\0%\5\6\0\16\6\0\0>\1\6\0014\1\1\0007\1\2\0017\1\3\1'\2\0\0%\3\4\0%\4\a\0%\5\6\0\16\6\0\0>\1\6\0014\1\1\0007\1\2\0017\1\3\1'\2\0\0%\3\4\0%\4\b\0%\5\t\0\16\6\0\0>\1\6\0014\1\1\0007\1\2\0017\1\3\1'\2\0\0%\3\4\0%\4\n\0%\5\v\0\16\6\0\0>\1\6\0014\1\1\0007\1\2\0017\1\3\1'\2\0\0%\3\4\0%\4\f\0%\5\r\0\16\6\0\0>\1\6\0014\1\1\0007\1\2\0017\1\3\1'\2\0\0%\3\4\0%\4\14\0%\5\15\0\16\6\0\0>\1\6\1G\0\1\0\21<C-\\><C-n><C-W>l\n<C-l>\21<C-\\><C-n><C-W>k\n<C-k>\21<C-\\><C-n><C-W>j\n<C-j>\21<C-\\><C-n><C-W>h\n<C-h>\ajk\15<C-\\><C-n>\n<esc>\6t\24nvim_buf_set_keymap\bapi\bvim\1\0\1\fnoremap\2$\0\0\2\1\1\0\5+\0\0\0\16\1\0\0007\0\0\0>\0\2\1G\0\1\0\1¿\vtoggle$\0\0\2\1\1\0\5+\0\0\0\16\1\0\0007\0\0\0>\0\2\1G\0\1\0\2¿\vtoggle„\a\1\0\b\0(\0M4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0'\2\20\0T\3\1Ä1\2\3\0:\2\5\0012\2\0\0:\2\6\0014\2\a\0007\2\b\0027\2\t\2:\2\t\0013\2\n\0003\3\v\0:\3\f\2:\2\r\1>\0\2\0014\0\14\0001\1\16\0:\1\15\0004\0\a\0007\0\17\0%\1\18\0>\0\2\0014\0\0\0%\1\19\0>\0\2\0027\0\20\0\16\2\0\0007\1\21\0003\3\22\0>\1\3\2\16\3\0\0007\2\21\0003\4\23\0>\2\3\0021\3\24\0005\3\25\0001\3\26\0005\3\27\0004\3\a\0007\3\28\0037\3\29\3%\4\30\0%\5\31\0%\6 \0003\a!\0>\3\5\0014\3\a\0007\3\28\0037\3\29\3%\4\"\0%\5\31\0%\6 \0003\a#\0>\3\5\0014\3\a\0007\3\28\0037\3\29\3%\4\30\0%\5$\0%\6%\0003\a&\0>\3\5\0014\3\a\0007\3\28\0037\3\29\3%\4\"\0%\5$\0%\6%\0003\a'\0>\3\5\0010\0\0ÄG\0\1\0\1\0\2\vsilent\2\fnoremap\2\1\0\2\vsilent\2\fnoremap\2$<cmd>lua _normterm_toggle()<CR>\n<A-i>\1\0\2\vsilent\2\fnoremap\2\6t\1\0\2\vsilent\2\fnoremap\2#<cmd>lua _lazygit_toggle()<CR>\n<A-l>\6n\20nvim_set_keymap\bapi\21_normterm_toggle\0\20_lazygit_toggle\0\1\0\2\vhidden\2\14direction\15horizontal\1\0\3\vhidden\2\14direction\nfloat\bcmd\flazygit\bnew\rTerminal\24toggleterm.terminal:autocmd! TermOpen term://* lua set_terminal_keymaps()\bcmd\0\25set_terminal_keymaps\a_G\15float_opts\15highlights\1\0\2\15background\vNormal\vborder\vNormal\1\0\2\rwinblend\3\0\vborder\vcurved\nshell\6o\bvim\20shade_filetypes\tsize\1\0\b\20shade_terminals\2\19shading_factor\3\2\14direction\15horizontal\18close_on_exit\2\20start_in_insert\2\20insert_mappings\2\17persist_size\2\17hide_numbers\2\0\nsetup\15toggleterm\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2·\5\0\0\3\0\21\00054\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\1\0'\1\0\0:\1\5\0004\0\0\0007\0\1\0'\1\1\0:\1\6\0004\0\0\0007\0\1\0'\1\0\0:\1\a\0004\0\0\0007\0\1\0'\1\1\0:\1\b\0004\0\0\0007\0\1\0'\1\0\0:\1\t\0004\0\0\0007\0\1\0'\1\1\0:\1\n\0004\0\0\0007\0\1\0003\1\f\0:\1\v\0004\0\0\0007\0\1\0003\1\14\0:\1\r\0004\0\0\0007\0\1\0003\1\16\0003\2\17\0:\2\18\0013\2\19\0:\2\20\1:\1\15\0G\0\1\0\vfolder\1\0\5\fdefault\bÓóø\15empty_open\bÔÑï\topen\bÓóæ\nempty\bÔÑî\fsymlink\bÔíÇ\bgit\1\0\6\runstaged\bÔëÑ\fignored\b‚óå\14untracked\bÔÖá\runmerged\bÓúß\frenamed\b‚ûú\vstaged\bÔÄå\1\0\2\fdefault\bÓòí\fsymlink\bÔíÅ\20nvim_tree_icons\1\0\4\ffolders\3\1\nfiles\3\1\bgit\3\1\18folder_arrows\3\0\25nvim_tree_show_icons\1\3\0\0\rstartify\14dashboard\29nvim_tree_auto_ignore_ft\25nvim_tree_auto_close\30nvim_tree_lsp_diagnostics\21nvim_tree_follow\29nvim_tree_indent_markers\28nvim_tree_hide_dotfiles\28nvim_tree_disable_netrw\27nvim_tree_quit_on_open\30nvim_tree_respect_buf_cwd\25nvim_tree_update_cwd\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-autotag", "nvim-treesitter-textobjects", "nvim-ts-context-commentstring" },
    config = { "\27LJ\1\2í\t\0\0\6\0,\0/3\0\0\0004\1\1\0%\2\2\0>\1\2\0027\1\3\0013\2\4\0003\3\5\0:\3\6\0023\3\a\0:\3\b\0023\3\t\0:\3\n\0023\3\v\0:\3\f\0023\3\r\0:\3\14\0023\3\15\0:\3\16\0023\3\21\0003\4\17\0:\0\18\0043\5\19\0:\5\20\4:\4\22\0033\4\23\0003\5\24\0:\5\25\4:\4\26\0033\4\27\0003\5\28\0:\5\29\0043\5\30\0:\5\31\0043\5 \0:\5!\0043\5\"\0:\5#\4:\4$\0033\4%\0003\5&\0:\5'\0043\5(\0:\5)\4:\4*\3:\3+\2>\1\2\1G\0\1\0\16textobjects\tswap\18swap_previous\1\0\3\bghc\17@class.outer\bghp\21@parameter.inner\bghf\20@function.outer\14swap_next\1\0\3\bglp\21@parameter.inner\bglf\20@function.outer\bglc\17@class.outer\1\0\1\venable\2\tmove\22goto_previous_end\1\0\2\a[M\20@function.outer\a[]\17@class.outer\24goto_previous_start\1\0\2\a[m\20@function.outer\a[[\17@class.outer\18goto_next_end\1\0\2\a]M\20@function.outer\a][\17@class.outer\20goto_next_start\1\0\2\a]m\20@function.outer\a]]\17@class.outer\1\0\2\14set_jumps\2\venable\2\vselect\fkeymaps\1\0\n\aic\17@class.inner\aai\23@conditional.outer\aib\17@block.inner\aac\17@class.outer\aal\16@loop.outer\aif\20@function.inner\ail\16@loop.inner\aii\23@conditional.inner\aab\17@block.outer\aaf\20@function.outer\1\0\2\14lookahead\2\venable\2\16lsp_interop\1\0\0\25peek_definition_code\1\0\1\agp\20@function.outer\vborder\1\0\1\venable\2\14highlight\1\0\1\venable\2\vindent\1\0\1\venable\2\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\fautotag\1\0\1\venable\2\14autopairs\1\0\1\venable\2\21ignore_installed\1\2\0\0\fhaskell\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚îå\b‚îê\b‚îò\b‚îî\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring"
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
    config = { "\27LJ\1\2p\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\15ignore_lsp\1\0\1\16show_hidden\2\1\2\0\0\15solargraph\nsetup\17project_nvim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/project.nvim"
  },
  snap = {
    config = { "\27LJ\1\2ü\1\0\0\4\6\6\0\19+\0\0\0007\0\0\0003\1\1\0+\2\1\0+\3\2\0>\2\2\2:\2\2\1+\2\3\0007\2\3\2:\2\3\1+\2\4\0007\2\4\2:\2\4\0012\2\3\0+\3\5\0;\3\1\2:\2\5\1>\0\2\1G\0\1\0\0¿\1¿\3¿\b¿\t¿\n¿\nviews\16multiselect\vselect\rproducer\1\0\1\vprompt\20 ÔÖú Files Ôê≤ \brun†\1\0\0\5\5\6\0\20+\0\0\0007\0\0\0003\1\1\0+\2\1\0'\3\16'+\4\2\0>\2\3\2:\2\2\1+\2\3\0007\2\3\2:\2\3\1+\2\3\0007\2\4\2:\2\4\0012\2\3\0+\3\4\0;\3\1\2:\2\5\1>\0\2\1G\0\1\0\0¿\2¿\4¿\t¿\v¿\nviews\16multiselect\vselect\rproducer\1\0\1\vprompt\19 Ôú´ Grep Ôê≤ \brun›\1\0\0\5\5\v\0\26+\0\0\0007\0\0\0003\1\1\0+\2\1\0'\3\16'+\4\2\0>\2\3\2:\2\2\1+\2\3\0007\2\3\2:\2\3\1+\2\3\0007\2\4\2:\2\4\0012\2\3\0+\3\4\0;\3\1\2:\2\5\0014\2\6\0007\2\a\0027\2\b\2%\3\t\0>\2\2\2:\2\n\1>\0\2\1G\0\1\0\0¿\2¿\4¿\t¿\v¿\19initial_filter\f<cword>\vexpand\afn\bvim\nviews\16multiselect\vselect\rproducer\1\0\1\vprompt\19 Ôú´ Grep Ôê≤ \brunë\1\0\0\4\4\6\0\17+\0\0\0007\0\0\0003\1\1\0+\2\1\0:\2\2\1+\2\2\0007\2\3\2:\2\3\1+\2\2\0007\2\4\2:\2\4\0012\2\3\0+\3\3\0;\3\1\2:\2\5\1>\0\2\1G\0\1\0\0¿\a¿\b¿\n¿\nviews\16multiselect\vselect\rproducer\1\0\1\vprompt\18 Ôû° Git Ôê≤ \brunü\1\0\0\4\5\6\0\19+\0\0\0007\0\0\0003\1\1\0+\2\1\0+\3\2\0>\2\2\2:\2\2\1+\2\3\0007\2\3\2:\2\3\1+\2\3\0007\2\4\2:\2\4\0012\2\3\0+\3\4\0;\3\1\2:\2\5\1>\0\2\1G\0\1\0\0¿\1¿\5¿\b¿\n¿\nviews\16multiselect\vselect\rproducer\1\0\1\vprompt\22 Ô¨ò Buffers Ôê≤ \brun†\1\0\0\4\5\6\0\19+\0\0\0007\0\0\0003\1\1\0+\2\1\0+\3\2\0>\2\2\2:\2\2\1+\2\3\0007\2\3\2:\2\3\1+\2\3\0007\2\4\2:\2\4\0012\2\3\0+\3\4\0;\3\1\2:\2\5\1>\0\2\1G\0\1\0\0¿\1¿\6¿\b¿\n¿\nviews\16multiselect\vselect\rproducer\1\0\1\vprompt\23 ÔÖú Oldfiles Ôê≤ \brun¡\5\1\0\17\0#\0A4\0\0\0%\1\1\0>\0\2\0027\1\2\0%\2\3\0>\1\2\0027\2\2\0%\3\4\0>\2\2\0027\3\2\0%\4\5\0>\3\2\0027\3\6\0033\4\a\0>\3\2\0027\4\2\0%\5\b\0>\4\2\0027\5\2\0%\6\t\0>\5\2\0027\6\2\0%\a\n\0>\6\2\0027\a\2\0%\b\3\0>\a\2\0027\b\2\0%\t\v\0>\b\2\0=\a\0\0027\b\2\0%\t\f\0>\b\2\0027\t\2\0%\n\r\0>\t\2\0027\n\2\0%\v\14\0>\n\2\0027\v\2\0%\f\15\0>\v\2\0021\f\16\0005\f\17\0001\f\18\0005\f\19\0001\f\20\0005\f\21\0001\f\22\0005\f\23\0001\f\24\0005\f\25\0001\f\26\0005\f\27\0004\f\28\0007\f\29\f7\f\30\f%\r\31\0%\14 \0%\15!\0003\16\"\0>\f\5\0010\0\0ÄG\0\1\0\1\0\2\vsilent\2\fnoremap\2\31<cmd>lua SnapBuffers()<CR>\14<leader>b\6n\20nvim_set_keymap\bapi\bvim\17SnapOldFiles\0\16SnapBuffers\0\fSnapGit\0\25SnapGrepSelectedWord\0\rSnapGrep\0\14SnapFiles\0\20preview.vimgrep\17preview.file\19select.vimgrep\16select.file\22producer.git.file\25producer.vim.oldfile\24producer.vim.buffer\29producer.ripgrep.vimgrep\1\4\0\0\r--hidden\f--iglob/!vendor/* !node_modules/* !target/* !git/*\targs\26producer.ripgrep.file\19consumer.limit\17consumer.fzf\bget\tsnap\frequire\0" },
    load_after = {
      ["which-key.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/snap"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\2•\2\0\0\5\0\17\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\15\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0002\4\0\0:\4\t\3:\3\n\0023\3\f\0003\4\v\0:\4\r\3:\3\14\2:\2\16\1>\0\2\1G\0\1\0\rdefaults\1\0\0\fpickers\15find_files\1\0\0\1\0\1\vhidden\2\rmappings\6i\1\0\0\18layout_config\1\0\3\18preview_width\3P\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\16borderchars\1\0\0\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚îå\b‚îê\b‚îò\b‚îî\nsetup\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\1\2c\0\0\2\0\6\0\t4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\4\0%\1\5\0>\0\2\1G\0\1\0\27colorscheme tokyonight\bcmd\nnight\21tokyonight_style\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim"
  },
  ["which-key.nvim"] = {
    after = { "snap" },
    config = { "\27LJ\1\2¿\23\0\0\6\0k\0û\0014\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\6\0003\2\3\0003\3\4\0:\3\5\2:\2\a\0013\2\b\0:\2\t\0013\2\n\0003\3\v\0:\3\f\0023\3\r\0:\3\14\2:\2\15\0013\2\17\0003\3\16\0:\3\18\0023\3\19\0:\3\20\2:\2\21\0013\2\22\0:\2\23\1>\0\2\0013\0\24\0004\1\25\0007\1\26\0017\1\27\1%\2\28\0%\3\29\0%\4\30\0003\5\31\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2\28\0%\3 \0%\4!\0003\5\"\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2\28\0%\3#\0%\4$\0003\5%\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2&\0%\3#\0%\4$\0003\5'\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2\28\0%\3(\0%\4)\0003\5*\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2\28\0%\3+\0%\4,\0003\5-\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2\28\0%\3.\0%\4/\0003\0050\0>\1\5\0014\1\25\0007\1\26\0017\1\27\1%\2\28\0%\0031\0%\0042\0003\0053\0>\1\5\0013\0014\0003\0025\0003\0036\0:\0037\0023\0038\0:\0039\0023\3:\0:\3;\0023\3<\0:\3=\2:\2>\0013\2?\0003\3@\0:\3A\0023\3B\0:\3C\0023\3D\0:\3E\0023\3F\0:\3G\0023\3H\0:\3I\0023\3J\0:\3K\0023\3L\0:\3M\0023\3N\0:\3O\2:\2G\0013\2P\0003\3Q\0:\3R\0023\3S\0:\3T\0023\3U\0:\3V\0023\3W\0:\3X\0023\3Y\0:\3Z\0023\3[\0:\3\\\0023\3]\0:\3^\0023\3_\0:\3E\2:\2K\0013\2`\0003\3a\0:\3b\0023\3c\0:\3d\0023\3e\0:\3G\0023\3f\0:\3g\0023\3h\0:\3&\2:\2i\0014\2\0\0%\3\1\0>\2\2\0027\3j\2\16\4\1\0\16\5\0\0>\3\3\1G\0\1\0\rregister\6l\1\3\0\0/<cmd>lua vim.lsp.buf.type_definition()<cr>\20Type Definition\6r\1\3\0\0&<cmd>lua vim.lsp.buf.rename()<cr>\vRename\1\3\0\0*<cmd>lua vim.lsp.buf.formatting()<cr>\15LSP Finder\6i\1\3\0\0\21<cmd>LspInfo<cr>\tInfo\6a\1\3\0\0+<cmd>lua vim.lsp.buf.code_action()<cr>\16Code Action\1\0\1\tname\t+LSP\1\3\0\0000<cmd>lua require'gitsigns'.blame_line()<cr>\15Blame Line\bpvh\1\3\0\0002<cmd>lua require'gitsigns'.preview_hunk()<cr>\17Preview Hunk\arb\1\3\0\0002<cmd>lua require'gitsigns'.reset_buffer()<cr>\17Reset Buffer\arh\1\3\0\0000<cmd>lua require'gitsigns'.reset_hunk()<cr>\15Reset Hunk\bush\1\3\0\0005<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>\17Unstage Hunk\ash\1\3\0\0000<cmd>lua require'gitsigns'.stage_hunk()<cr>\15Stage Hunk\aph\1\3\0\0/<cmd>lua require'gitsigns'.prev_hunk()<cr>\18Previous Hunk\anh\1\3\0\0/<cmd>lua require'gitsigns'.next_hunk()<cr>\14Next Hunk\1\0\1\tname\t+Git\aof\1\3\0\0 <cmd>lua SnapOldFiles()<CR>\19Find Old Files\asw\1\3\0\0(<cmd>lua SnapGrepSelectedWord()<CR>\23Find Selected Word\6g\1\3\0\0\27<cmd>lua SnapGit()<CR>\rFind Git\6w\1\3\0\0\28<cmd>lua SnapGrep()<CR>\14Find Word\6f\1\3\0\0\29<cmd>lua SnapFiles()<CR>\15Find Files\6b\1\3\0\0\31<cmd>lua SnapBuffers()<CR>\15Find Files\6x\1\3\0\0#<cmd> Telescope find_files<CR>\15Find Files\6e\1\3\0\0$<cmd>Telescope file_browser<cr>\17File Browser\1\0\1\tname\n+Find\6d\ald\1\3\0\0<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>\26Show Line Diagnostics\agp\1\3\0\0000<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>\17Get Previous\agn\1\3\0\0000<cmd>lua vim.lsp.diagnostic.goto_next()<cr>\rGet Next\aga\1\3\0\0.<cmd>lua vim.lsp.diagnostic.get_all()<cr>\fGet All\1\0\1\tname\16Diagnostics\1\0\b\6e\rExplorer\6C$Close All Except Current Buffer\6w\tSave\6/\fComment\6b\fBuffers\6c\17Close Buffer\f<space>\26Switch to Last Buffer\6q\tQuit\1\0\2\vsilent\2\fnoremap\2\f:q!<CR>\14<leader>q\1\0\2\vsilent\2\fnoremap\2\v:w<CR>\14<leader>w\1\0\2\vsilent\2\fnoremap\2\21<cmd>BufOnly<CR>\14<leader>C\1\0\2\vsilent\2\fnoremap\2\17:bdelete<CR>\14<leader>c\1\0\2\vsilent\2\fnoremap\2\6t\1\0\2\vsilent\2\fnoremap\2\20:ToggleTerm<CR>\n<A-i>\1\0\2\vsilent\2\fnoremap\2\n<C-^>\20<leader><space>\1\0\2\vsilent\2\fnoremap\2\24:NvimTreeToggle<CR>\14<leader>e\6n\20nvim_set_keymap\bapi\bvim\1\0\5\vnowait\1\tmode\6n\vprefix\r<leader>\vsilent\2\fnoremap\2\vhidden\1\t\0\0\r<silent>\n<cmd>\n<cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmax\0032\bmin\3\20\vheight\1\0\1\fspacing\3\3\1\0\2\bmax\3\25\bmin\3\4\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\2\rposition\vbottom\vborder\vsingle\nicons\1\0\3\ngroup\6+\14separator\b‚ûú\15breadcrumb\a¬ª\fplugins\1\0\1\14show_help\2\fpresets\1\0\a\6g\2\6z\2\fwindows\1\fmotions\1\bnav\2\17text_objects\2\14operators\1\1\0\2\14registers\1\nmarks\2\nsetup\14which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jraines/.local/share/nvim/site/pack/packer/opt/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\1\2F\0\1\6\0\3\0\b4\1\0\0007\1\1\0017\1\2\1\16\2\0\0)\3\2\0)\4\2\0)\5\2\0@\1\5\0\27nvim_replace_termcodes\bapi\bvimõ\1\0\0\5\0\b\2\0284\0\0\0007\0\1\0007\0\2\0%\1\3\0>\0\2\2\21\0\0\0\b\0\1\0T\1\18Ä4\1\0\0007\1\1\0017\1\4\1%\2\3\0>\1\2\2\16\2\1\0007\1\5\1\16\3\0\0\16\4\0\0>\1\4\2\16\2\1\0007\1\6\1%\3\a\0>\1\3\2\v\1\0\0T\1\2Ä)\1\1\0T\2\1Ä)\1\2\0H\1\2\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0?\0\2\4\1\4\0\a+\2\0\0007\2\1\0027\2\2\0027\3\3\0016\2\3\2:\2\0\1H\1\2\0\1¿\tkind\fdefault\fpresets\tmenuC\0\1\3\0\4\0\a4\1\0\0%\2\1\0>\1\2\0027\1\2\0017\2\3\0>\1\2\1G\0\1\0\tbody\15lsp_expand\fluasnip\frequireú\2\0\1\4\3\n\1-4\1\0\0007\1\1\0017\1\2\1>\1\1\2\t\1\0\0T\1\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\4\0>\2\2\2%\3\5\0>\1\3\1T\1\29Ä+\1\1\0007\1\6\1>\1\1\2\15\0\1\0T\2\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\a\0>\2\2\2%\3\b\0>\1\3\1T\1\15Ä+\1\2\0>\1\1\2\15\0\1\0T\2\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\t\0>\2\2\2%\3\5\0>\1\3\1T\1\2Ä\16\1\0\0>\1\1\1G\0\1\0\3¿\2¿\4¿\n<tab>\5!<Plug>luasnip-expand-or-jump\23expand_or_jumpable\6n\n<C-n>\rfeedkeys\15pumvisible\afn\bvim\2’\1\0\1\4\2\t\1!4\1\0\0007\1\1\0017\1\2\1>\1\1\2\t\1\0\0T\1\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\4\0>\2\2\2%\3\5\0>\1\3\1T\1\17Ä+\1\1\0007\1\6\1'\2ˇˇ>\1\2\2\15\0\1\0T\2\tÄ4\1\0\0007\1\1\0017\1\3\1+\2\0\0%\3\a\0>\2\2\2%\3\b\0>\1\3\1T\1\2Ä\16\1\0\0>\1\1\1G\0\1\0\3¿\2¿\5\28<Plug>luasnip-jump-prev\rjumpable\6n\n<C-p>\rfeedkeys\15pumvisible\afn\bvim\2¡\4\1\0\v\0)\0B4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\0\0%\3\3\0>\2\2\0021\3\4\0001\4\5\0007\5\6\0003\6\n\0003\a\b\0001\b\a\0:\b\t\a:\a\v\0063\a\r\0001\b\f\0:\b\14\a:\a\15\0063\a\18\0007\b\16\0007\b\17\b>\b\1\2:\b\19\a7\b\16\0007\b\20\b>\b\1\2:\b\21\a7\b\16\0007\b\22\b>\b\1\2:\b\23\a7\b\16\0007\b\24\b3\t\27\0007\n\25\0007\n\26\n:\n\28\t>\b\2\2:\b\29\a7\b\16\0001\t\30\0003\n\31\0>\b\3\2:\b \a7\b\16\0001\t!\0003\n\"\0>\b\3\2:\b#\a:\a\16\0062\a\5\0003\b$\0;\b\1\a3\b%\0;\b\2\a3\b&\0;\b\3\a3\b'\0;\b\4\a:\a(\6>\5\2\0010\0\0ÄG\0\1\0\fsources\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\f<S-tab>\1\3\0\0\6i\6s\0\n<tab>\1\3\0\0\6i\6s\0\t<CR>\rbehavior\1\0\1\vselect\2\vInsert\20ConfirmBehavior\fconfirm\n<C-e>\nclose\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\15formatting\1\0\0\vformat\1\0\0\0\nsetup\0\0\fluasnip\flspkind\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-ts-context-commentstring'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-ts-autotag', 'nvim-ts-context-commentstring'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-ts-context-commentstring'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType js ++once lua require("packer.load")({'nvim-lsp-ts-utils', 'nvim-ts-context-commentstring'}, { ft = "js" }, _G.packer_plugins)]]
vim.cmd [[au FileType vue ++once lua require("packer.load")({'nvim-ts-autotag', 'nvim-lsp-ts-utils', 'nvim-ts-context-commentstring'}, { ft = "vue" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au UIEnter * ++once lua require("packer.load")({'tokyonight.nvim', 'telescope.nvim', 'nvim-tree.lua', 'lualine.nvim'}, { event = "UIEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'null-ls.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-comment', 'gitsigns.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'which-key.nvim', 'nvim-toggleterm.lua'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'project.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
