return {
    -- TODO: SUBSTITUIR O NEOTREE POR ISSO
    'stevearc/oil.nvim',

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},

    lazy = false,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Go back to Oil.nvim" },
    },

    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
