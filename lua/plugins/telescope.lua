return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            -- obligatory
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            -- optionals
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
            -- extensions
            {
                "debugloop/telescope-undo.nvim",
                keys = { { "<leader>U", "<cmd>Telescope undo<cr>" } },
                config = function()
                require("telescope").load_extension("undo")
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
                keys = {
                    {"<leader>fr", "<Cmd>Telescope frecency<CR>", desc = "Telescope frecency"},
                },
                lazy = true,
                config = function()
                    require("telescope").load_extension "frecency"
                end
            },
            {
                "nvim-telescope/telescope-media-files.nvim", -- ONLY WORKING ON SIXEL COMPATIBLE TERMINALS (windows terminal doesn't 2023)
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
                lazy = true,
                config = function()
                    require('telescope').load_extension('media_files')
                end
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
                keys = {
                    {"<space>fb", "<cmd>Telescope file_browser<CR>", desc = "Telescope file browser" },
                },
                lazy = true,
                config = function()
                    require("telescope").load_extension "file_browser"
                end
            },
        },
        keys = {
            {'<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Telescope find files"},
            {'<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>" , desc = "Telescope live grep"},
            {'<leader>fB', "<cmd>lua require('telescope.builtin').buffers()<CR>"   , desc = "Telescope buffer list"},
            {'<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>" , desc = "Telescope help tags"},
        },
        lazy = true,
        opts = {
            ----- for some reson this doesnt work
            -- defaults = { -- trouble plugin config
            --     mappings = {
            --         i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
            --         n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
            --     },
            -- },
            extensions = { -- media_files plugin config
                media_files = {
                    -- filetypes whitelist
                    -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                    filetypes = {"png", "webp", "jpg", "jpeg"},
                    find_cmd = "rg" -- find command (defaults to `fd`)
                },
                file_browser = {
                    theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                        -- your custom insert mode mappings
                        },
                        ["n"] = {
                        -- your custom normal mode mappings
                        },
                    },
                },
            },
        }
    } -- fuzzy finder
}
