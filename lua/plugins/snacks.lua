return {
    "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        debug = { enabled = true },
        dim = { enabled = true },
        -- explorer = { enabled = true },
        indent = { enabled = true },
        -- input = { enabled = true },
        -- picker = { enabled = true }, -- telescope already does this
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        -- rename = { enabled = true },
        -- scroll = { enabled = true }, -- already handled by neoscroll.nvim
        statuscolumn = { enabled = true },
        -- words = { enabled = true }, -- not sure what it does
    },
}
