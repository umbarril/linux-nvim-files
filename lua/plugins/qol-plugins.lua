return {
    -- {"OmniSharp/OmniSharp-vim"}, -- TODO: Learn how to use this
    -- "dhruvasagar/vim-table-mode" 
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
}
