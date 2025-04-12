return {
    { -- LSP
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "stevearc/dressing.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "folke/neodev.nvim",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local util = lspconfig.util

            -- Force all LSP servers to look for the nearest .git folder
            lspconfig.util.default_config =
                vim.tbl_extend("force", lspconfig.util.default_config, {
                    root_dir = function(fname)
                        return util.find_git_ancestor(fname)
                            or util.path.dirname(fname)
                    end,
                })

            local servers = {
                clangd = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "-j=12",
                        "--query-driver=**",
                        "--clang-tidy",
                        "--all-scopes-completion",
                        "--cross-file-rename",
                        "--completion-style=detailed",
                        "--header-insertion-decorators",
                        "--header-insertion=iwyu",
                        "--pch-storage=memory",
                        "--suggest-missing-includes",
                    },
                },
                rust_analyzer = {
                    imports = {

                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {

                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true,
                    },
                },
                stimulus_ls = {},
                ts_ls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }, -- Set vim as a keyword recognized
                            },
                        },
                    },
                },
            }

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup(
                    "lsp-attach",
                    { clear = true }
                ),
                callback = function(ev)
                    local map = function(k, f, d)
                        vim.keymap.set("n", k, f, { buffer = ev.buf, desc = d })
                    end

                    map(
                        "gd",
                        require("telescope.builtin").lsp_definitions,
                        "[G]oto [D]efinition"
                    )
                    map(
                        "gI",
                        require("telescope.builtin").lsp_implementations,
                        "[G]oto [I]mplementation"
                    )
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("K", vim.lsp.buf.hover, "Hover")

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    if
                        client
                        and client.server_capabilities.documentHighlightProvider
                    then
                        local grp =
                            vim.api.nvim_create_augroup("lsp-highlight", {})
                        vim.api.nvim_create_autocmd(
                            { "CursorHold", "CursorHoldI" },
                            {
                                buffer = ev.buf,
                                group = grp,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )
                        vim.api.nvim_create_autocmd(
                            { "CursorMoved", "CursorMovedI" },
                            {
                                buffer = ev.buf,
                                group = grp,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )
                    end

                    if
                        client
                        and client.server_capabilities.inlayHintProvider
                        and vim.lsp.inlay_hint
                    then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled()
                            )
                        end, "Toggle Inlay Hints")
                    end
                end,
            })

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(servers),
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup(
                        servers[server_name] or {}
                    )
                end,
            })
        end,
    },

    { -- Formatters
        "stevearc/conform.nvim",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local formatters =
                { "stylua", "prettier", "pretty-php", "clang-format" }

            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = formatters,
            })

            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    html = { "prettier" },
                    css = { "prettier" },
                    javascript = { "prettier" },
                    php = { "pretty-php" },
                    arduino = { "clang_format" },
                    cpp = { "clang_format" },
                },

                formatters = {
                    stylua = {
                        prepend_args = {
                            "--indent-width",
                            "4",
                            "--indent-type",
                            "Spaces",
                            "--column-width",
                            "80",
                        },
                    },
                    prettier = {
                        prepend_args = {
                            "--tab-width",
                            "4",
                            "--print-width",
                            "80",
                        },
                    },
                    clang_format = {
                        args = {
                            "--style={BasedOnStyle: llvm, IndentWidth: 4}",
                        },
                    },
                },

                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 1000,
                },
            })
        end,
    },

    { -- Completion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = {

                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                completion = { completeopt = "menu,menuone,noinsert" },

                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
}
