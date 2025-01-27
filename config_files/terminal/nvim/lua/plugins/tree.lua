return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            {
                "\\",
                ":Neotree reveal position=current<CR>",
                { desc = "NeoTree reveal" },
            },
        },
        opts = {
            filesystem = {
                window = {
                    mappings = {
                        ["\\"] = "close_window",
                    },
                },
            },
        },
    },
}
