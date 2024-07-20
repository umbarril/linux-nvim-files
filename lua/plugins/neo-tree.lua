return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        { "<leader>n", "<cmd>Neotree filesystem reveal right<CR>", desc="Open neotree on the right" },
    },
    config = function ()
        -- If you want icons for diagnostic errors, you'll need to define them somewhere:
        vim.fn.sign_define("DiagnosticSignError",
            {text = " ", texthl = "DiagnosticSignError"})
        vim.fn.sign_define("DiagnosticSignWarn",
            {text = " ", texthl = "DiagnosticSignWarn"})
        vim.fn.sign_define("DiagnosticSignInfo",
            {text = " ", texthl = "DiagnosticSignInfo"})
        vim.fn.sign_define("DiagnosticSignHint",
            {text = "󰌵", texthl = "DiagnosticSignHint"})

        -- require("neo-tree").paste_default_config()
        require("neo-tree").setup({
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
            source_selector = {
                winbar = true,
                statusline = false -- i don't know what this option does
            }
        })

        vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
}

