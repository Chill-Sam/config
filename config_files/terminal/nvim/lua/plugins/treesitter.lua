return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "lua",
            "luadoc",
            "html",
            "css",
            "javascript",
            "jsdoc",
            "json",
            "markdown",
            "markdown_inline",
        },

        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = { enable = true },
    },
}
