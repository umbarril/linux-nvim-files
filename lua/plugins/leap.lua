return {
-- EasyMotion-like plugins
    -- "phaazon/hop.nvim", -- deprecated, the original one
    -- "smoka7/hop.nvim", -- the alternative
-- https://github.com/mfussenegger/nvim-treehopper
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
    }
}
