vim.g.dashboard_custom_header = {

   '███╗░░██╗███████╗░█████╗░██████╗░░█████╗░██╗███╗░░██╗',
   '████╗░██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██║████╗░██║',
   '██╔██╗██║█████╗░░██║░░██║██████╔╝███████║██║██╔██╗██║',
   '██║╚████║██╔══╝░░██║░░██║██╔══██╗██╔══██║██║██║╚████║',
   '██║░╚███║███████╗╚█████╔╝██║░░██║██║░░██║██║██║░╚███║',
   '╚═╝░░╚══╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝',

}

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
    b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    c = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    d = {description = {'  Marks              '}, command = 'Telescope marks'},
    e = {description = {'  Load Last Session  '}, command = 'SessionLoad'}
}

vim.g.dashboard_custom_footer = {"Jonathan Raines"}
