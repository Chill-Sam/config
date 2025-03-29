return {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
        local md = require("render-markdown")
        md.enable()
        md.setup({
            render_modes = true,
        })
    end,
}
