return {
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
    },
    {
	    "williamboman/mason-lspconfig.nvim",
	    dependencies = {
            {"williamboman/mason.nvim"},
            {
                "SmiteshP/nvim-navic",
                -- dependencies = {"neovim/nvim-lspconfig"},
                opts = {
                     icons = {
                        File = ' ',
                        Module = ' ',
                        Namespace = ' ',
                        Package = ' ',
                        Class = ' ',
                        Method = ' ',
                        Property = ' ',
                        Field = ' ',
                        Constructor = ' ',
                        Enum = ' ',
                        Interface = ' ',
                        Function = ' ',
                        Variable = ' ',
                        Constant = ' ',
                        String = ' ',
                        Number = ' ',
                        Boolean = ' ',
                        Array = ' ',
                        Object = ' ',
                        Key = ' ',
                        Null = ' ',
                        EnumMember = ' ',
                        Struct = ' ',
                        Event = ' ',
                        Operator = ' ',
                        TypeParameter = ' '
                    },
                    lsp = {
                        auto_attach = false,
                        preference = nil,
                    },
                    highlight = false,
                    separator = " > ",
                    depth_limit = 0,
                    depth_limit_indicator = "..",
                    safe_output = true,
                    lazy_update_context = false,
                    click = false,
                    format_text = function(text)
                        return text
                    end,
                }
            },
        },
        -- https://github.com/chancez/dotfiles/commit/8257f38876e130f3e227932295cb40058c080049?diff=unified
        config = function()
            local default_on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- deprecated
                vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {buf=bufnr})

                local buf_map = function(mapping, cmd)
                    vim.keymap.set('n', mapping, cmd, { noremap = true, silent = true, buffer=bufnr })
                end

                buf_map('gD', vim.lsp.buf.declaration)
                buf_map('gd', vim.lsp.buf.definition)
                buf_map('K', vim.lsp.buf.hover)
                buf_map('gi', vim.lsp.buf.implementation)
                -- buf_map('<C-k>', vim.lsp.buf.signature_help)
                buf_map('<leader>wa', vim.lsp.buf.add_workspace_folder)
                buf_map('<leader>wr', vim.lsp.buf.remove_workspace_folder)
                buf_map('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end)
                buf_map('<leader>D', vim.lsp.buf.type_definition)
                -- buf_map('<leader>rn', vim.lsp.buf.rename)
                buf_map('gR', vim.lsp.buf.references)
                -- buf_map('<C-.>', vim.lsp.buf.code_action) -- nao funciona
                buf_map('<leader>e', vim.diagnostic.open_float)
                buf_map('[d', vim.diagnostic.goto_prev)
                buf_map(']d', vim.diagnostic.goto_next)
                -- buf_map(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
                buf_map('<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])

                vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

                if client.server_capabilities.documentSymbolProvider then
                    -- print("chegou")
                    require('nvim-navic').attach(client, bufnr)
                end
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end

            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')
            -- local nvim_runtime = vim.api.nvim_get_runtime_file('', true)

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                                -- Setup your lua path
                                path = runtime_path,
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                -- and fix 'Undefined global `vim`' errors
                                globals = { 'vim' },
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.env.VIMRUNTIME,
                                -- stop annoying third party library messages
                                checkThirdParty = false,
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = { enable = false },
                        }
                    }
                },
            }
            require('mason-lspconfig').setup {
                ensure_installed = { "lua_ls", "clangd", "pyright" --[[ "rust_analyzer" ]] },
            }
            require('mason-lspconfig').setup_handlers {
                -- default handler - setup with default settings
                function (server_name)
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
                    local server_opts = {
                        on_attach = default_on_attach,
                        capabilities = capabilities,
                        flags = {
                            debounce_text_changes = 150,
                        },
                    }
                    local server_specific_opts = servers[server_name]
                    if server_specific_opts == nil then
                        -- print("No specific config found for: " .. server_name .. ". Proceeding with defaults...")
                        require("lspconfig")[server_name].setup(server_opts)
                        return
                    end
                    for k,v in pairs(server_specific_opts) do
                        server_opts[k] = v
                    end
                    require("lspconfig")[server_name].setup(server_opts)
                end
            }
        end
    },
}
