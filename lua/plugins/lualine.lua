return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "SmiteshP/nvim-navic",
            "folke/noice.nvim",
        },
        opts = { -- same as setup {}
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'},
                lualine_c = {
                    {
                        "navic",
                        -- Component specific options
                        color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
                        -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
                        -- Setting it to "static" will perform a adjustment once when the component is being setup. This should
                        --   be enough when the lualine section isn't changing colors based on the mode.
                        -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
                        --   the current section.
                        navic_opts = nil  -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
                    }
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = {}
        }
    },
}
