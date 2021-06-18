require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
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
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
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

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- telescope
-- vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', {noremap = true, silent = true})

-- dashboard
vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

-- Buffer pick
vim.api.nvim_set_keymap("n", "<leader>b", ":BufferPick<CR>", {noremap = true, silent = true})

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>q", ":BufferClose<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>Q", ":BufferCloseAllButCurrent<CR>", {noremap = true, silent = true})

-- open projects
vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'telescope'.extensions.project.project{}<CR>",
                        {noremap = true, silent = true})

local mappings = {
    ["/"] = "Comment",
    ["q"] = "Close Buffer",
    ["e"] = "Explorer",
    ["b"] = "Open Buffers",
    ["h"] = "No Highlight",
    ["p"] = "Projects",
    d = {
        name = "+Diagnostics",
        t = {"<cmd>TroubleToggle<cr>", "trouble"},
        w = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        W = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document Dagnostics"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
        l = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "references"},
        s = {"<cmd>SymbolsOutline<cr>", "Symbols Outline"},
    },
    N = {
        name = '+Native Diagnostics',
        ga = {"<cmd>lua vim.lsp.diagnostic.get_all()<cr>", "Get All"},
        gn = {"<cmd>lua vim.lsp.diagnostic.get_next()<cr>", "Get Next"},
        gp = {"<cmd>lua vim.lsp.diagnostic.get_prev()<cr>", "Get Previous"},
        gtn = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Go to Next"},
        gtp = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Go to Previous"},
        sld = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Show Line Diagnostics"},
    },
    D = {
        name = "+Debug",
        b = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"},
        c = {"<cmd><lua require'dap'.continue()<cr>", "Continue"},
        i = {"<cmd>lua require'dap'.step_into()<cr>", "Step Into"},
        o = {"<cmd>lua require'dap'.step_over()<cr>", "Step Over"},
        r = {"<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl"},
        s = {"<cmd>lua require'dap'.continue()<cr>", "Start"}
    },
    f = {
        name = "+Find",
        b = {"<cmd>Telescope buffers<cr>", "Open buffers"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        ds = {"<cmd>Telescope lsp_document_symbols<cr>", "Colorscheme"},
        e = {"<cmd>Telescope file_browser<cr>", "File Browser"},
        f = {"<cmd>Telescope find_files<cr>", "Find Files"},
        g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
        h = {"<cmd>Telescope help_tags<cr>", "Help Tags"},
        i = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Current Buffer"},
        km = {"<cmd>Telescope keymaps<cr>", "Find Keymaps"},
        m = {"<cmd>Telescope marks<cr>", "Marks"},
        mp = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        of = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
        ts = {"<cmd>Telescope treesitter<cr>", "File Browser"},
        td = {"<cmd>TodoTelescope<cr>", "Find TODO's"},
        vo = {"<cmd>Telescope vim_options<cr>", "Find Vim Options"},
        w = {"<cmd>Telescope grep_string<cr>", "Grep String"},
        ws = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Colorscheme"},
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
        bl = {"<cmd>lua require'gitsigns'.blame_line()<cr>", "Blame Line"},
    },
    l = {
        name = "+LSP",
        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        f = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        l = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        t = {"<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition"},
    },
    n = {
        name = "+Native LSP",
        ca = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Native Code Action"},
        awf = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace Folder"},
        cr = {"<cmd>lua vim.lsp.buf.clear_references()<cr>", "Clear References"},
        dc = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration"},
        df = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Definition"},
        dh = {"<cmd>lua vim.lsp.buf.document_highlight()<cr>", "Document Highlight"},
        ds = {"<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document Symbol"},
        f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting"},
        fs = {"<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "Formatting Sync"},
        h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
        i = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation"},
        ic = {"<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Incoming Calls"},
        lwf = {"<cmd>lua vim.lsp.buf.list_workspace_folders()<cr>", "List Workspace Folders"},
        oc = {"<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "List Outgoing Calls"},
        rca = {"<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Range Code Action"},
        rf = {"<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Range Formatting"},
        r = {"<cmd>lua vim.lsp.buf.references()<cr>", "References"},
        rwf = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace Folder"},
        rn = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        sh = {"<cmd>lua vim.lsp.signature_help()<cr>", "Signature Help"},
        ws = {"<cmd>lua vim.lsp.workspace_symbol()<cr>", "Workspace Symbol"},
    },
    s = {
        name = "+Session",
        s = {"<cmd>SessionSave<cr>", "Save Session"},
        l = {"<cmd>SessionLoad<cr>", "Load Session"}
    },
}

local wk = require("which-key")
wk.register(mappings, opts)
