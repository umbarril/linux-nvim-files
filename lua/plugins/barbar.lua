return {
    { -- prettier substitution for :tabe .
        "romgrk/barbar.nvim",
        event = "BufEnter",
        keys = {
            {"<leader>1","<cmd>BufferGoto 1<CR>", desc = "Go to buffer 1"},
            {"<leader>2","<cmd>BufferGoto 2<CR>", desc = "Go to buffer 2"},
            {"<leader>3","<cmd>BufferGoto 3<CR>", desc = "Go to buffer 3"},
            {"<leader>4","<cmd>BufferGoto 4<CR>", desc = "Go to buffer 4"},
            {"<leader>5","<cmd>BufferGoto 5<CR>", desc = "Go to buffer 5"},
            {"<leader>6","<cmd>BufferGoto 6<CR>", desc = "Go to buffer 6"},
            {"<leader>7","<cmd>BufferGoto 7<CR>", desc = "Go to buffer 7"},
            {"<leader>8","<cmd>BufferGoto 8<CR>", desc = "Go to buffer 8"},
            {"<leader>9","<cmd>BufferGoto 9<CR>", desc = "Go to buffer 9"},
            {"<leader>0","<cmd>BufferLast<CR>", desc = "Go to last buffer"},
            {"<leader>,","<cmd>BufferPrevious<CR>", desc = "Go to previous buffer"},
            {"<leader>.","<cmd>BufferNext<CR>", desc = "Go to next buffer"},
            {"<leader><","<cmd>BufferMovePrevious<CR>", desc = "Move buffer to previous"},
            {"<leader>>","<cmd>BufferMoveNext<CR>", desc = "Move buffer to next"},
            {'<leader>c>', '<Cmd>BufferClose<CR>', desc = "Close buffer"},
            {'<leader>p>', '<Cmd>BufferPin<CR>', desc = "Pin buffer"},
            {'<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', desc = "Order buffer by directory"},
            {'<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', desc = "Order buffer by directory"},
            {'<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', desc = "Order buffer by language"},
            {'<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', desc = "Order window by number"},
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = { },
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
}
