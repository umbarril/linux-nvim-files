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
                keys = { { "<leader>fu", "<cmd>Telescope undo<cr>" } },
                config = function()
                require("telescope").load_extension("undo")
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
                keys = {
                    {"<leader>fR", "<Cmd>Telescope frecency<CR>", desc = "Telescope frecency"},
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
        },
        keys = {
            {'<leader>ff', function() require('telescope.builtin').find_files() end, desc = "Telescope Find Files"},
            {'<C-S-n>', function() require('telescope.builtin').live_grep() end, desc = "Telescope Livegrep"}, -- neovide only

            {'<leader>fg', function() require('telescope.builtin').live_grep() end, desc = "Telescope Livegrep"},
            {'<C-S-f>', function() require('telescope.builtin').live_grep() end, desc = "Telescope Livegrep"}, -- neovide only

            {'<leader>fg', function() require('telescope.builtin').grep_string() end, desc = "Telescope Find Word", mode = 'v' },
            {'<C-S-f>', function() require('telescope.builtin').grep_string() end, desc = "Telescope Find Word", mode = 'v' },

            {'<leader>fs', function() require('telescope.builtin').lsp_workspace_symbols() end, desc = "Telescope Workspace Symbols" },
            {'<leader>ft', function() require('telescope.builtin').treesitter() end, desc = "Telescope Treesitter" },
            {'<leader>fe', function() require('telescope.builtin').diagnostics() end, desc = "Telescope Diagnostics"},
            {'<leader>fB', function() require('telescope.builtin').buffers() end, desc = "Telescope Buffer List"},
            {'<leader>fh', function() require('telescope.builtin').help_tags() end, desc = "Telescope Help Tags"},
            {'<leader>?', function() require('telescope.builtin').keymaps() end, desc = "Telescope Keymaps"},
            {'<leader>fgc', function() require('telescope.builtin').git_bcommits() end, desc = "Telescope Git Buffer Commits"},
            {'<leader>fgC', function() require('telescope.builtin').git_commits() end, desc = "Telescope Git Commits"},
            {'<leader>fgb', function() require('telescope.builtin').git_branches() end, desc = "Telescope Git Branches"},
            {'<leader>fo', function() require('telescope.builtin').oldfiles() end, desc = "Telescope Old Files"},
            {'<leader>fd', function() require('telescope.builtin').lsp_type_definitions() end, desc = "Telescope Type Definitions"},
            {'<leader>fD', function() require('telescope.builtin').lsp_definitions() end, desc = "Telescope Definitions"},

            {'<leader>fr', function() require('telescope.builtin').lsp_references() end, desc = "Telescope Lsp References", mode = "" },
            {'<leader>u', function() require('telescope.builtin').lsp_references() end, desc = "Telescope Lsp References", mode = "" },
        },
        lazy = false,
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                            ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                    }
                },
                extensions = { -- media_files plugin config
                    media_files = {
                        -- filetypes whitelist
                        filetypes = {"png", "webp", "jpg", "jpeg"},
                        find_cmd = "rg" -- find command (defaults to `fd`)
                    },
                },
            })

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argv(0) == "" then
                        require("telescope.builtin").oldfiles()
                    end
                end,
            })
        end,
    } -- fuzzy finder
}
