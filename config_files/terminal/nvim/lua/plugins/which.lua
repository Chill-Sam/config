return {
    { -- Shows pending keybinds
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("which-key").setup()

            require("which-key").add({
                { "<leader>s", group = "[S]earch" },
            })
        end,
    },
}
