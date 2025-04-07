return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        { "<leader>n", "<cmd>Neotree filesystem reveal right<CR>", desc="Open neotree on the right" },
    },
    config = function ()
        -- hyjacking netrw
        vim.api.nvim_create_autocmd('BufNewFile', {
              group    = vim.api.nvim_create_augroup('RemoteFile', {clear = true}),
              callback = function()
                local f = vim.fn.expand('%:p')
                for _, v in ipairs{'sftp', 'scp', 'ssh', 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync'} do
              local p = v .. '://'
              if string.sub(f, 1, #p) == p then
                vim.cmd[[
                          unlet g:loaded_netrw
                                    unlet g:loaded_netrwPlugin
                                    runtime! plugin/netrwPlugin.vim
                                    silent Explore %
                                  ]]
                vim.api.nvim_clear_autocmds{group = 'RemoteFile'}
                break
              end
            end
              end
        })

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
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
            require 'window-picker'.setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { 'terminal', "quickfix" },
                    },
            },
        })
        end,
      },
    }
}

