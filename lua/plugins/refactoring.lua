return  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    -- lazy = false,
    
    keys = {
        { "<leader>re", function() return require('refactoring').refactor('Extract Function') end, mode = "x" },
        { "<leader>rf", function() return require('refactoring').refactor('Extract Function To File') end, mode = "x" },
        { "<leader>rv", function() return require('refactoring').refactor('Extract Variable') end, mode = "x"  },
        { "<leader>rI", function() return require('refactoring').refactor('Inline Function') end, mode = "x" },
        { "<leader>ri", function() return require('refactoring').refactor('Inline Variable') end, mode = "x" },
        { "<leader>rbb", function() return require('refactoring').refactor('Extract Block') end, mode = "x"},
        { "<leader>rbf", function() return require('refactoring').refactor('Extract Block To File') end, mode = "x"}
    },
    config = function()
        require("refactoring").setup()
    end,
}
