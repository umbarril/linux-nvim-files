return {
    -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
    -- nyoom-engineering/oxocarbon.nvim << cool theme
    { -- theme
        "Mofiqul/vscode.nvim",
        config = function()
            vim.o.background = 'dark'
            vim.cmd.colorscheme "vscode"
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { }
    },
    { -- colorizes color hexes with rgb
        "NvChad/nvim-colorizer.lua",
        config = true
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            vim.g.Illuminate_delay = 300
        end
    },
    -- add indentation lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        -- enabled= false,
        config = function()
            local highlight = {
                "CursorColumn",
                "Whitespace",
            }
            require("ibl").setup {
                indent = { highlight = highlight, char = "" },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = { enabled = false },
            }
        end,
        version = "V3.4.2",
        opts = {},
    },
    {
        "petertriho/nvim-scrollbar",
        config = true
    },
    { -- adds fold symbols to the left column
        "lewis6991/foldsigns.nvim",
        config = true
    },
    -- {   "folke/styler.nvim" } -- a plugin to set a different colorscheme depending on the filetype
    -- {
    --     "folke/zen-mode.nvim",
    --     dependencies = {
    --         {
    --             "folke/twilight.nvim", -- not a dependecy, but if I use zen mode I might as well use this too
    --             opts = { }
    --         },
    --     },
    --     opts = { }
    -- },
    -- { -- expands current window size
    --     "anuvyklack/windows.nvim",
    --     dependencies = {
    --         "anuvyklack/middleclass",
    --         "anuvyklack/animation.nvim"
    --     },
    --     config = function()
    --         vim.o.winwidth = 10
    --         vim.o.winminwidth = 10
    --         vim.o.equalalways = false
    --         require('windows').setup()
    --     end
    -- },
}

