return {
    {
        "folke/trouble.nvim", -- TODO: config this better
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        config = function ()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })

            local actions = require("telescope.actions")
            local open_with_trouble = require("trouble.sources.telescope").open

            -- Use this to add more results without clearing the trouble list
            local add_to_trouble = require("trouble.sources.telescope").add

            local telescope = require("telescope")

            telescope.setup({
            defaults = {
                mappings = {
                    i = { ["<c-t>"] = open_with_trouble },
                    n = { ["<c-t>"] = open_with_trouble },
                    },
                },
            })
        end,
        keys = {
            {
                    "<leader>xx",
                    "<cmd>Trouble diagnostics toggle<cr>",
                    desc = "Diagnostics (Trouble)",
                },
            {
                    "<leader>xX",
                    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                    desc = "Buffer Diagnostics (Trouble)",
                },
            {
                    "<leader>cs",
                    "<cmd>Trouble symbols toggle focus=false<cr>",
                    desc = "Symbols (Trouble)",
                },
            {
                    "<leader>cl",
                    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                    desc = "LSP Definitions / references / ... (Trouble)",
                },
            {
                    "<leader>xL",
                    "<cmd>Trouble loclist toggle<cr>",
                    desc = "Location List (Trouble)",
                },
            {
                    "<leader>xQ",
                    "<cmd>Trouble qflist toggle<cr>",
                    desc = "Quickfix List (Trouble)",
                },
            },
    },
}
