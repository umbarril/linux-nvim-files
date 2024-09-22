return {
    -- {"OmniSharp/OmniSharp-vim"}, -- TODO: Learn how to use this
    -- "dhruvasagar/vim-table-mode" 
    -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
    -- nyoom-engineering/oxocarbon.nvim << cool theme
    -- https://github.com/Wansmer/treesj -- test later
    -- monaqa/dial.nvim
    -- danymat/neogen
    -- { "ThePrimeagen/refactoring.nvim", config = true}, -- TODO: learn how to use it
    -- { "ThePrimeagen/harpoon", branch = "harpoon2", config = true },

    -- folke/flash.nvim
    -- gbprod/yanky.nvim
    --
    -- >>>>> this plugin echasnovski/mini.nvim
    -- from what I've seen, it does much of the stuff I do but in 1 plug
    -- maybe try it later?
    -- for making wikis
    -- "https://github.com/vimwiki/vimwiki"
    -- {
    --     "renerocksai/telekasten.nvim",
    --     ft = { "md", "markdown" }
    -- },
    {
        --  JSON front matter highlight plugin
        'elzr/vim-json',
        -- ft = { "*.md", "*.markdwn" }
    },
    {
        'plasticboy/vim-markdown',
        -- ft = { "*.md", "*.markdwn" }
    },
    {
        "prashanthellina/follow-markdown-links",
        -- ft = { "*.md", "*.markdwn" }
    },

    -- gui
    -- {   "folke/styler.nvim" } -- a plugin to set a different colorscheme depending on the filetype
    {
        'andymass/vim-matchup',
        setup = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    {
        "folke/zen-mode.nvim",
        dependencies = {
            {
                "folke/twilight.nvim", -- not a dependecy, but if I use zen mode I might as well use this too
                opts = { }
            },
        },
        opts = { }
    },
    { -- expands current window size
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup()
        end
    },
    {
        "petertriho/nvim-scrollbar",
        config = true
    },
    -- { -- stating page
    --     'goolord/alpha-nvim',
    --     dependencies = { 'nvim-teee/nvim-web-devicons' },
    --     config = function()
    --         require'alpha'.setup(require'alpha.themes.dashboard'.config)
    --     end
    -- },
    -- { -- automatically manages sessions
    --     "folke/persistence.nvim",
    --     event = "BufReadPre", -- this will only start session saving when an actual file was opened
    --     opts = {
    --         options = {--[[<other options>,]] 'globals'},
    --         pre_save = function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end,
    --     },
    --     dependencies = {
    --         "barbar.nvim"
    --     }
    -- },
    { -- may be better than alpha, idk
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
            -- config
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },
    { -- adds fold symbols to the left column
        "lewis6991/foldsigns.nvim",
        config = true
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeoutlen = 700
            vim.o.timeout = true
            require("which-key").setup{}
        end,
    },

    -- moving/writing swiftly
    -- cshuaimin/ssr.nvim <<<< see this later
    -- {
    --     'windwp/nvim-autopairs',
    --     lazy=true,
    --     event = "InsertEnter",
    --     opts = {} -- this is equalent to setup({}) function
    -- },
    { "psliwka/vim-smoothie" },

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
    }
}
