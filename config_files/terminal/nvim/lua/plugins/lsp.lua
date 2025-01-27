return {
    { -- LSP
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            local servers = {
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
            local formatters = { "stylua" }

            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = formatters,
            })

            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
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
            "L3MON4DE/LuaSnip",
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
