-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- https://github.com/glepnir/lspsaga.nvim/blob/b88299f477b05435fccf8f8405569d30153b4d82/lua/lspsaga/command.lua
-- https://github.com/glepnir/lspsaga.nvim/search?q=command
require("lazy").setup {
    -- {"OmniSharp/OmniSharp-vim"}, -- TODO: Learn how to use this
    -- https://github.com/svermeulen/vim-yoink -- try thuis
    -- "cohama/lexima.vim", -- auto-close parenthesis
    --- https://github.com/ggandor/leap.nvim
    -- https://github.com/bkad/CamelCaseMotion
    -- https://github.com/easymotion/vim-easymotion

    -- wiki
    -- { "renerocksai/telekasten.nvim" }
    -- "https://github.com/vimwiki/vimwiki"
    -- "dhruvasagar/vim-table-mode" 
    --Konfekt/FastFold
    -- prashanthellina/follow-markdown-links

    -- diagnostics
    {
        "folke/trouble.nvim", -- TODO: config this better
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
            {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
            {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
            {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
            {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
            {silent = true, noremap = true}
            )
            vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
            {silent = true, noremap = true}
            )
        end,
        config = true,
    },
    -- themes
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('lualine').setup{
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
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
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
        end
    },
    { "norcalli/nvim-colorizer.lua", },
    -- "folke/tokyonight.nvim", -- TODO: try this later
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[ colorscheme gruvbox ]]
        end
    },
    -- moving 
    { "psliwka/vim-smoothie", },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                -- LHS of operator-pending mapping in NORMAL + VISUAL mode
                opleader = {
                    -- line-comment keymap
                    line = "gc",
                    -- block-comment keymap
                    block = "gb",
                },
                -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                mappings = {
                    -- operator-pending mapping
                    -- Includes:
                    --  `gcc`               -> line-comment  the current line
                    --  `gcb`               -> block-comment the current line
                    --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
                    --  `gb[count]{motion}` -> block-comment the region contained in {motion}
                    basic = true,
                    -- extra mapping
                    -- Includes `gco`, `gcO`, `gcA`
                    extra = true,
                    -- extended mapping
                    -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                    extended = true,
                },
                -- LHS of toggle mapping in NORMAL + VISUAL mode
                toggler = {
                    -- line-comment keymap
                    --  Makes sense to be related to your opleader.line
                    line = "gcc",
                    -- block-comment keymap
                    --  Make sense to be related to your opleader.block
                    block = "gbc",
                },
                -- Pre-hook, called before commenting the line
                --    Can be used to determine the commentstring value
                pre_hook = nil,
                -- Post-hook, called after commenting is done
                --    Can be used to alter any formatting / newlines / etc. after commenting
                post_hook = nil,
                -- Can be used to ignore certain lines when doing linewise motions.
                --    Can be string (lua regex)
                --    Or function (that returns lua regex)
                ignore = nil,
            }
            require("Comment.ft").set("lua", { "--%s", "--[[%s]]" })
        end
    },
    {
        "kylechui/nvim-surround", config = true -- do this config properly later
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-media-files.nvim", -- ONLY WORKING ON LINUX
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = { "kkharji/sqlite.lua" },
                config = function()
                    vim.api.nvim_set_keymap("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
                end
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                config = function()
                    vim.api.nvim_set_keymap(
                    "n",
                    "<space>fb",
                    ":Telescope file_browser",
                    { noremap = true }
                    )
                end
            }
        },
        init = function()
            vim.keymap.set('n', '<leader>ff', function()
                require('telescope.builtin').find_files()
            end, {})
            vim.keymap.set('n', '<leader>fg', function()
                require('telescope.builtin').live_grep()
            end, {})
            vim.keymap.set('n', '<leader>fb', function()
                require('telescope.builtin').buffers()
            end, {})
            vim.keymap.set('n', '<leader>fh', function()
                require('telescope.builtin').help_tags()
            end, {})
        end,
        config = function()
            require"telescope".setup {
                defaults = { -- trouble plugin config
                    mappings = {
                    i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
                    n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
                    },
                },
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
            require"telescope".load_extension("file_browser")
            -- require"telescope".load_extension('media_files')
            -- require"telescope".load_extension("frecency")
        end
    }, -- fuzzy finder
    -- lsp and treesitter stuff
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "nvim-treesitter/playground" }
        },
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                        enable = true, -- false will disable the whole extension
                        additional_vim_regex_highlighting = true,
                        ["foo.bar"] = "Identifier",
                        ["TODO"] = "Identifier",
                        ["BUG"] = "Identifier",
                        ["ERROR"] = "Identifier",
                        ["DONE"] = "Identifier",
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = 'gnn',
                        node_incremental = 'grn',
                        scope_incremental = 'grc',
                        node_decremental = 'grm',
                    },
                },
                indent = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                },
                -- treesitter playground conf (nvim-treesitter/playground)
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                },
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = {"BufWrite", "CursorHold"},
                },
            }

            -- enable tree-sitter based folding
            vim.cmd [[
            set foldmethod=expr
            set foldexpr=nvim_treesitter#foldexpr()
            ]]
        end
    },
    { "nvim-treesitter/nvim-treesitter-textobjects"},
    -- "folke/lsp-colors.nvim",
    { "ThePrimeagen/refactoring.nvim", config = true}, -- TODO: learn how to use it
    { "ThePrimeagen/harpoon", config = true },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeoutlen = 300
            vim.o.timeout = true
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    { "williamboman/mason.nvim", config = true },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            {
                "RRethy/vim-illuminate",
                config = function()
                    vim.g.Illuminate_delay = 300
                end
            },
            {
                "Hoffs/omnisharp-extended-lsp.nvim",
                dependencies = { "nvim-telescope/telescope.nvim" },
                config = function() -- integration with telescope
                    vim.api.nvim_create_autocmd("FileType", {
                    pattern = "*",
                    callback = function()
                        local bufnr = vim.api.nvim_get_current_buf()
                        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
                        if ft == "c_sharp" or ft == "cs" or ft == "csharp" then
                            vim.keymap.set('n', "gd", require('omnisharp_extended').telescope_lsp_definitions,
                                    { noremap = true, silent = true, buffer=bufnr })
                        end
                    end,
                    })
                end
            },
        },
        -- https://github.com/chancez/dotfiles/commit/8257f38876e130f3e227932295cb40058c080049?diff=unified
        config = function()
            local default_on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                local buf_map = function(mapping, cmd)
                    vim.keymap.set('n', mapping, cmd, { noremap = true, silent = true, buffer=bufnr })
                end

                buf_map('gD', vim.lsp.buf.declaration)
                buf_map('gd', vim.lsp.buf.definition)
                buf_map('K', vim.lsp.buf.hover)
                buf_map('gi', vim.lsp.buf.implementation)
                buf_map('<C-k>', vim.lsp.buf.signature_help)
                buf_map('<leader>wa', vim.lsp.buf.add_workspace_folder)
                buf_map('<leader>wr', vim.lsp.buf.remove_workspace_folder)
                buf_map('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end)
                buf_map('<leader>D', vim.lsp.buf.type_definition)
                buf_map('<leader>rn', vim.lsp.buf.rename)
                buf_map('gr', vim.lsp.buf.references)
                buf_map('<C-.>', vim.lsp.buf.code_action)
                buf_map('<leader>e', vim.diagnostic.open_float)
                buf_map('[d', vim.diagnostic.goto_prev)
                buf_map(']d', vim.diagnostic.goto_next)
                -- buf_map(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
                buf_map('<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])

                vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
                require 'illuminate'.on_attach(client)
            end

            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')
            local nvim_runtime = vim.api.nvim_get_runtime_file('', true)
            local servers = {
                sumneko_lua = {
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
                                library = nvim_runtime,
                                -- stop annoying third party library messages
                                checkThirdParty = false,
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = { enable = false },
                        }
                    }
                },
                omnisharp = {
                    cmd = { "dotnet", "~/omnisharp/OmniSharp.dll"}, -- "/path/to/omnisharp/OmniSharp.dll"

                    handlers = {
                        ["textDocument/definition"] = require('omnisharp_extended').handler,
                    },
                    -- Enables support for reading code style, naming convention and analyzer
                    -- settings from .editorconfig.
                    enable_editorconfig_support = true,
                    -- If true, MSBuild project system will only load projects for files that
                    -- were opened in the editor. This setting is useful for big C# codebases
                    -- and allows for faster initialization of code navigation features only
                    -- for projects that are relevant to code that is being edited. With this
                    -- setting enabled OmniSharp may load fewer projects and may thus display
                    -- incomplete reference lists for symbols.
                    enable_ms_build_load_projects_on_demand = false,
                    -- Enables support for roslyn analyzers, code fixes and rulesets.
                    enable_roslyn_analyzers = false,
                    -- Specifies whether 'using' directives should be grouped and sorted during
                    -- document formatting.
                    organize_imports_on_format = false,
                    -- Enables support for showing unimported types and unimported extension
                    -- methods in completion lists. When committed, the appropriate using
                    -- directive will be added at the top of the current file. This option can
                    -- have a negative impact on initial completion responsiveness,
                    -- particularly for the first few completion sessions after opening a
                    -- solution.
                    enable_import_completion = false,
                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    sdk_include_prereleases = true,
                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    analyze_open_documents_only = false,
                }
            }
            require('mason-lspconfig').setup()
            require('mason-lspconfig').setup_handlers {
                -- default handler - setup with default settings
                function (server_name)
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
                    local server_opts = {
                        on_attach = default_on_attach,
                        capabilities = capabilities,
                        flags = {
                        debounce_text_changes = 150,
                        },
                    }
                    local server_specific_opts = servers[server_name]
                    if server_specific_opts == nil then
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
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim", -- vscode like autocomplete option pane
            {
                "hrsh7th/vim-vsnip",
                dependencies= {
                    "hrsh7th/vim-vsnip-integ",
                    "rafamadriz/friendly-snippets"
                },
            },
        },
        config = function()
		    local cmp = require('cmp')
            cmp.setup {
                snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
                },
                window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
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
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
        -- https://github.com/glepnir/lspsaga.nvim/blob/b88299f477b05435fccf8f8405569d30153b4d82/lua/lspsaga/command.lua
		init = function()
			local keymap = vim.keymap.set

			-- LSP finder - Find the symbol's definition
			-- If there is no definition, it will instead be hidden
			-- When you use an action in finder like "open vsplit",
			-- you can use <C-t> to jump back
			keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

			-- Code action
			keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

			-- Rename all occurrences of the hovered word for the entire file
			keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

			-- Peek definition
			-- You can edit the file containing the definition in the floating window
			-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
			-- It also supports tagstack
			-- Use <C-t> to jump back
			--keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

			-- Go to definition
			keymap("n","gd", function()
				require('lspsaga.definition'):goto_definition()
			end)

			-- Show line diagnostics
			-- You can pass argument ++unfocus to
			-- unfocus the show_line_diagnostics floating window
			keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

			-- Show cursor diagnostics
			-- Like show_line_diagnostics, it supports passing the ++unfocus argument
			keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

			-- Show buffer diagnostics
			keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

			-- Diagnostic jump
			-- You can use <C-o> to jump back to your previous location
			keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
			keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

			-- Diagnostic jump with filters such as only jumping to an error
			keymap("n", "[E", function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end)
			keymap("n", "]E", function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end)

			-- Toggle outline
			keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

			-- Hover Doc
			-- If there is no hover doc,
			-- there will be a notification stating that
			-- there is no information available.
			-- To disable it just use ":Lspsaga hover_doc ++quiet"
			-- Pressing the key twice will enter the hover window
			keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

			-- If you want to keep the hover window in the top right hand corner,
			-- you can pass the ++keep argument
			-- Note that if you use hover with ++keep, pressing this key again will
			-- close the hover window. If you want to jump to the hover window
			-- you should use the wincmd command "<C-w>w"
			keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

			-- Call hierarchy
			keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
			keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

			-- Floating terminal
			keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
		end,
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = { {"nvim-tree/nvim-web-devicons"} }
	},
}

-- autocmds and sets
local opt = vim.opt

vim.cmd [[ 
filetype plugin on
filetype indent on
]]

vim.cmd [[
    " nnoremap gd <cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>
    
    " Let 'tl' toggle between this and the last accessed tab
    let g:lasttab = 1

    nnoremap <Leader>tl :exe "tabn ".g:lasttab<CR>

    au TabLeave * let g:lasttab = tabpagenr()
]]

vim.cmd [[

    " stop vim to autocomment when pressing o/O or Enter
    augroup NoAutoComment
    au!
    au FileType * setlocal formatoptions-=cr
    " read more in :h 'formatoptions'
    augroup end

    au TabLeave * let g:lasttab = tabpagenr()

    " copied from https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/init.vim
    " and https://www.youtube.com/watch?v=n9k9scbTuvQ
    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
    augroup END

    autocmd VimResized * wincmd =

    " copied from https://github.com/nickjj/dotfiles/blob/19397b0f4cdd98feb38f94612851235b8f0d883e/.vimrc#L376-L380
    autocmd BufNewFile,BufRead requirements*.txt set ft=python
    autocmd BufNewFile,BufRead .*aliases set ft=sh

    " Ensure tabs don't get converted to spaces in Makefiles.
    autocmd FileType make setlocal noexpandtab

    autocmd BufWinLeave *.* mkview
    autocmd BufWinLeave *.* silent loadview

    " automatically format everytime you save the file
    " autocmd BufWritePost * exe "normal! gg=G\<C-o>zz"

    " change scroll offset
    autocmd VimResized,VimEnter,WinEnter * let &scrolloff = winheight(0) / 6

    au FocusGained,BufEnter * checktime

    highlight ColorColmn ctermbg=0 guibg=lightgrey
    function! VisualSelection(direction, extra_filter) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", "\\/.*'$^~[]")
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'gv'
            call CmdLine("Ack '" . l:pattern . "' " )
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

    " make gx work on packge.json (https://doriankarter.com/customize-vims-gx-mapping/)
    function! PackageJsonGx() abort
        let l:line = getline('.')
        let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')

        if len(l:package) > 0
            let l:package_name = l:package[1]
            let l:url = 'https://www.npmjs.com/package/' . l:package_name
            call netrw#BrowseX(l:url, 0)
        endif
    endfunction

    augroup PackageJsonGx
        autocmd!
        autocmd BufRead,BufNewFile package.json nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>
    augroup END

    " make gx work in plug manager (https://doriankarter.com/customize-vims-gx-mapping/)
    function! PlugGx()
        let l:line = getline('.')
        let l:sha  = matchstr(l:line, '^  \X*\zs\x\{7,9}\ze ')

        if (&filetype ==# 'vim-plug')
            " inside vim plug splits such as :PlugStatus
            let l:name = empty(l:sha)
                        \ ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
                        \ : getline(search('^- .*:$', 'bn'))[2:-2]
        else
            " in .vimrc.bundles
            let l:name = matchlist(l:line, '\v/([A-Za-z0-9\-_\.]+)')[1]
        endif

        let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')
        if l:uri !~? 'github.com'
            return
        endif
        let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
        let l:url  = empty(l:sha)
                    \ ? 'https://github.com/'.l:repo
                    \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
        call netrw#BrowseX(l:url, 0)
    endfunction

    augroup PlugGxGroup
        autocmd!
        autocmd BufRead,BufNewFile plugins.lua nnoremap <buffer> <silent> gx :call PlugGx()<cr>
        autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
    augroup END

    " TODO: make gx work on obsidian.md markdown files
    function! ObsidianMD() abort
        let l:line = getline('.')
        let [line, column] = getpos('.')
        let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')

        if len(l:package) > 0
            call netrw#BrowseX(l:url, 0)
        endif
    endfunction

    " a way of making folds look better
    " stolen from https://github.com/nvim-treesitter/nvim-treesitter/pull/390
    function! GetSpaces(foldLevel)
        if &expandtab == 1
            Indenting with spaces
            let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
            return str
        elseif &expandtab == 0
            " Indenting with tabs
            return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
        endif
    endfunction

    function! MyFoldText()
        let startLineText = getline(v:foldstart)
        let endLineText = trim(getline(v:foldend))
        let indentation = GetSpaces(foldlevel("."))
        let spaces = repeat(" ", 200)

        let str = indentation . startLineText . "..." . endLineText . spaces

        return str
    endfunction

    " Custom display for text when folding
    set foldtext=MyFoldText()
]]

-- Use visual bell (no beeping)
opt.visualbell = true

-- Lets me use the mouse just like any other text editor
opt.mouse = 'a'
opt.history = 500

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append "Cargo.lock"
opt.wildignore:append "**/.git/"
opt.wildignore:append "*_build/"
opt.wildignore:append "**/node_modules/"

opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true
opt.termguicolors = true

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.undofile = true

require('mappings')

