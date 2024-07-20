return {
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
}

