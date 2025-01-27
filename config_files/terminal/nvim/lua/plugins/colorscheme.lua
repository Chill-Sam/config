return {
    { 
        "navarasu/onedark.nvim",
        priority = 1000, -- Load first
        opts = {
            style = "dark",
            transparent = true,
            code_style = { comments = "italic" },
        },
        init = function()
            require("onedark").load()
        end,
    },
}
