return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-cmdline",  lazy=true },
            { "hrsh7th/cmp-buffer",   lazy=true },
            { "hrsh7th/cmp-path",     lazy=true },
            { "hrsh7th/cmp-nvim-lua", lazy=true },
            { "hrsh7th/cmp-nvim-lsp", lazy=true },
            { "saadparwaiz1/cmp_luasnip", lazy=true},
            { "onsails/lspkind.nvim", lazy=true}, -- vscode like autocomplete option pane 
            {
                "hrsh7th/vim-vsnip",
                dependencies= {
                    "hrsh7th/vim-vsnip-integ",
                    "rafamadriz/friendly-snippets"
                },
                lazy=true
            },
        },
        event = "InsertEnter",
        config = function()
		    local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                window = { -- show code preview
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['S-Tab'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- [''] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' }, -- For vsnip users.
                },
		        {
                	{ name = 'buffer' },
                }),
                formatting = { -- lspkind config
                    format = require("lspkind").cmp_format({
                    mode = 'symbol', -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function (entry, vim_item)
                        return vim_item
                    end
                    })
                }
            }
            vim.o.completeopt = 'menuone,noselect'
        end
	},
}
