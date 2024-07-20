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
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         lsp = {
    --             -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --             override = {
    --             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --             ["vim.lsp.util.stylize_markdown"] = true,
    --             ["cmp.entry.get_documentation"] = true,
    --             },
    --         },
    --         -- Show @recording messages as a notify message (https://github.com/folke/noice.nvim/wiki/Configuration-Recipes)
    --         routes = {
    --             {
    --                 view = "notify",
    --                 filter = { event = "msg_showmode" },
    --             },
    --         },
    --         -- cmdline = {
    --         --     view = "cmdline",
    --         -- },
    --         -- you can enable a preset for easier configuration
    --         presets = {
    --             bottom_search = true, -- use a classic bottom cmdline for search
    --             command_palette = true, -- position the cmdline and popupmenu together
    --             long_message_to_split = true, -- long messages will be sent to a split
    --             inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --             lsp_doc_border = true, -- add a border to hover docs and signature help
    --         },
    --         -- messages = {
    --         --     backend = "mini"
    --         -- }
    --     },
    --     dependencies = {
    --         -- https://github.com/smjonas/inc-rename.nvim
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         -- OPTIONAL:
    --         --   `nvim-notify` is only needed, if you want to use the notification view.
    --         --   If not available, we use `mini` as the fallback
    --         {
    --             "rcarriga/nvim-notify",
    --             keys = {
    --                 {"<leader>d", ":lua require('notify').dismiss()<CR>", desc = "Dismiss notification"},
    --             },
    --             opts = {
    --                 render = "compact", -- default, compact, minimal, simple
    --                 stages = "fade", -- fade, fade_in_slide_out, slide, static
    --                 background_colour = "#000000",
    --                 timeout = 2500,
    --                 top_down = true,
    --             },
    --         },
    --     }
    -- },
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
    -- {
    --     "kylechui/nvim-surround", config = true -- do this config properly later
    -- },

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
