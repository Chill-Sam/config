return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "bash",
                "lua",
                "luadoc",
                "html",
                "css",
                "javascript",
                "tsx",
                "jsdoc",
                "json",
                "markdown",
                "markdown_inline",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
