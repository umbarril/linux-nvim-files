return {
    -- {"OmniSharp/OmniSharp-vim"}, -- TODO: Learn how to use this
    -- "dhruvasagar/vim-table-mode" 
    -- https://github.com/Wansmer/treesj -- test later
    -- monaqa/dial.nvim
    -- danymat/neogen
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
        event = "VeryLazy",
        config = function()
            vim.o.timeoutlen = 700
            vim.o.timeout = true
            require("which-key").setup{}
        end,
    },
    -- moving/writing swiftly
    -- cshuaimin/ssr.nvim <<<< see this later
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
}
