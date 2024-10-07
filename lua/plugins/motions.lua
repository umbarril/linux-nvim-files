return {
-- EasyMotion-like plugins
    -- "phaazon/hop.nvim", -- deprecated, the original one
    -- "smoka7/hop.nvim", -- the alternative
-- https://github.com/mfussenegger/nvim-treehopper
    { -- lua implementation of CameCaseMotion
        "chrisgrieser/nvim-spider",
        keys = {
            { -- example for lazy-loading on keystroke
                "e",
                "<cmd>lua require('spider').motion('e')<CR>",
                mode = { "n", "o", "x" },
            },
        },
    },
    -- vim-sneak-like plugin
    {
        "ggandor/leap.nvim",
        dependencies = {
            "tpope/vim-repeat" -- for dot-repeats (.) to work
        },
        config = function()
            require('leap').add_default_mappings()
        end
    },
    { -- F and T on steroids
        "ggandor/flit.nvim",
        dependencies = {
            "ggandor/leap.nvim",
            "tpope/vim-repeat",
        },
        config = true
    },
    -- return {
    --  "tpope/vim-surround"
    -- }
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'andymass/vim-matchup',
        setup = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    { "psliwka/vim-smoothie" },
}
