require 'harpoon'.setup {
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = true,
  },
}

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register({
    h = {
      name = 'Harpoon',
      ['p'] = { '<cmd>lua require("harpoon.mark").add_file()<CR>', 'Add File' },
      ['f'] = { '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', 'Go to file 1' },
      ['d'] = { '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', 'Go to file 2' },
      ['s'] = { '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', 'Go to file 3' },
      ['a'] = { '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', 'Go to file 4' },
      ['q'] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'Files Menu' },
      ['c'] = { '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', 'Commands Menu' },
      ['t'] = { '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>', 'Go to Terminal 1' },
      ['r'] = { '<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>', 'Go to Terminal 2' },
      ['T'] = { '<cmd>lua require("harpoon.tmux").gotoTerminal(1)<CR>', 'Go to Tmux Terminal 1' },
      ['R'] = { '<cmd>lua require("harpoon.tmux").gotoTerminal(2)<CR>', 'Go to Tmux Terminal 2' },
    },
  }, {
    prefix = '<leader>',
  })
end
