-- Set <space> as leader key before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode for resizing splits
vim.opt.mouse = 'a'

-- Don't show mode
vim.opt.showmode = false

-- Sync clipboard
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Tab option
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Signcolumn on
vim.opt.signcolumn = 'yes'

-- Updatetime
vim.opt.updatetime = 250

-- Displays whick-key sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Screen padding
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
-- [[ Movement ]]
-- Goto center of screen
vim.api.nvim_set_keymap(
    'n',
    '<C-d>',
    '<C-d>zz',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-u>',
    '<C-u>zz',
    { noremap = true, silent = true }
)

-- Splitscreen movement terminal fix
vim.keymap.set(
    't',
    '<C-w>h',
    [[<Cmd>wincmd h<CR>]],
    { desc = 'Move focus to the left window' }
)
vim.keymap.set(
    't',
    '<C-w>l',
    [[<Cmd>wincmd l<CR>]],
    { desc = 'Move focus to the right window' }
)

-- [[ Searching ]]
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ Diagnostics ]]
vim.diagnostic.enable()
vim.keymap.set(
    'n',
    '<leader>e',
    vim.diagnostic.open_float,
    { desc = 'Show diagnostic [E]rror messages' }
)

-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({
    { -- Theme
        'navarasu/onedark.nvim',
        priority = 1000, -- Load first
        opts = {
            style = 'dark',
            transparent = true,
            code_style = { comments = 'italic' },
        },
        init = function()
            require('onedark').load()
        end,
    },

    { -- Shows pending keybinds
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('which-key').setup()

            -- Existing key chains
            require('which-key').add {
                { '<leader>s', group = '[S]earch' },
            }
        end,
    },

    {
        'nvim-neo-tree/neo-tree.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        cmd = 'Neotree',
        keys = {
            { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
        },
        opts = {
            filesystem = {
                window = {
                    width = 30,
                    mappings = {
                        ['\\'] = 'close_window',
                    },
                },
            },
        },
    },

    {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
            open_mapping = [[<c-\>]],
            direction = 'vertical',
            insert_mappings = true,
            terminal_mappings = true,
            size = 60,
        },
    },

    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },

    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    'numToStr/Comment.nvim', -- "gc" to comment

    'tpope/vim-sleuth', -- Tab detection

    {
        'echasnovski/mini.statusline',
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = vim.g.have_nerd_font }
            statusline.section_location = function()
                return '%2l:%-2v'
            end
        end,
    },

    { -- Fuzzy finder
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            'nvim-telescope/telescope-ui-select.nvim',
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
            -- Configure telescope
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
                defaults = { file_ignore_patterns = { 'vendor' } },
            }

            -- Enable extensions
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require 'telescope.builtin'
            vim.keymap.set(
                'n',
                '<leader>sk',
                builtin.keymaps,
                { desc = '[S]earch [K]eymaps' }
            )
            vim.keymap.set(
                'n',
                '<leader>sf',
                builtin.find_files,
                { desc = '[S]earch [F]iles' }
            )
            vim.keymap.set(
                'n',
                '<leader>sg',
                builtin.live_grep,
                { desc = '[S]earch by [G]rep' }
            )
            -- Shortcut for searching your Neovim configuration files

            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },

    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            'j-hui/fidget.nvim',
            'folke/neodev.nvim',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup(
                    'lsp-attach',
                    { clear = true }
                ),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set(
                            'n',
                            keys,
                            func,
                            { buffer = event.buf, desc = desc }
                        )
                    end

                    map(
                        'gd',
                        require('telescope.builtin').lsp_definitions,
                        '[G]oto [D]efinition'
                    )

                    map(
                        'gI',
                        require('telescope.builtin').lsp_implementations,
                        '[G]oto [I]mplementation'
                    )

                    map(
                        '<leader>D',
                        require('telescope.builtin').lsp_type_definitions,
                        'Type [D]efinition'
                    )

                    map(
                        '<leader>ws',
                        require('telescope.builtin').lsp_dynamic_workspace_symbols,
                        '[W]orkspace [S]ymbols'
                    )

                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                    map('K', vim.lsp.buf.hover, 'Hover Documentation')

                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client.server_capabilities.documentHighlightProvider
                    then
                        local highlight_augroup = vim.api.nvim_create_augroup(
                            'lsp-highlight',
                            { clear = false }
                        )
                        vim.api.nvim_create_autocmd(
                            { 'CursorHold', 'CursorHoldI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )

                        vim.api.nvim_create_autocmd(
                            { 'CursorMoved', 'CursorMovedI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup(
                                'lsp-detach',
                                { clear = true }
                            ),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds {
                                    group = 'lsp-highlight',
                                    buffer = event2.buf,
                                }
                            end,
                        })
                    end

                    if
                        client
                        and client.server_capabilities.inlayHintProvider
                        and vim.lsp.inlay_hint
                    then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled()
                            )
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            local lspconfig = require 'lspconfig'
            local util = lspconfig.util
            lspconfig.util.default_config =
                vim.tbl_extend('force', lspconfig.util.default_config, {
                    root_dir = util.find_git_ancestor,
                })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                'force',
                capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- Enable the following language servers
            local servers = {
                ts_ls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            require('mason-tool-installer').setup {
                ensure_installed = ensure_installed,
            }

            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend(
                            'force',
                            {},
                            capabilities,
                            server.capabilities or {}
                        )
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    if
                        vim.fn.has 'win32' == 1
                        or vim.fn.executable 'make' == 0
                    then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
            },
            'saadparwaiz1/cmp_luasnip',

            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },

        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                completion = { completeopt = 'menu,menuone,noinsert' },

                mapping = cmp.mapping.preset.insert {
                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),

                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete {},

                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),

                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                },

                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
            }
        end,
    },

    { -- Autoformat
        'stevearc/conform.nvim',
        lazy = false,
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format {
                        async = true,
                        lsp_fallback = true,
                    }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },

        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,

            formatters_by_ft = {
                lua = { 'stylua' },
                javascript = { 'prettier' },
            },

            formatters = {
                stylua = {
                    prepend_args = {
                        '--indent-width',
                        '4',
                        '--indent-type',
                        'Spaces',
                        '--column-width',
                        '80',
                    },
                },
                prettier = {
                    prepend_args = {
                        '--tab-width',
                        '4',
                        '--print-width',
                        '80',
                    },
                },
            },
        },
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'diff',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        config = function(_, opts)
            -- [[ Configure Treesitter ]]

            -- Prefer git instead of curl in order to improve connectivity in some environments
            require('nvim-treesitter.install').prefer_git = true
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}, {
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})
