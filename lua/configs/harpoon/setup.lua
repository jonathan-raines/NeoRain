local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = {
  ['<leader>hp'] = '<cmd>lua require("harpoon.mark").add_file()<CR>',
  ['<leader>hq'] = '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
  ['<leader>ha'] = '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
  ['<leader>hs'] = '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
  ['<leader>hd'] = '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
  ['<leader>hf'] = '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
  ['<leader>ht'] = '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>',
  ['<leader>hy'] = '<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>',
  ['<leader>hl'] = '<cmd>lua require("harpoon.tmux").sendCommand(99, "lazygit && exit")<CR>',
}

for key, cmd in pairs(keymaps) do
  keymap('n', key, cmd, opts)
end

local mappings = {
  h = {
    name = 'Harpoon',
    p = { 'Add File' },
    q = { 'Menu' },
    a = { 'Navigate to File 1' },
    s = { 'Navigate to File 2' },
    d = { 'Navigate to File 3' },
    f = { 'Navigate to File 4' },
    t = { 'Navigate to Terminal 1' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
