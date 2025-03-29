vim.cmd([[
    highlight! yank-highlight guifg=#ffffff guibg=#EE82EE gui=bold
]])

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "yank-highlight", timeout = 200 })
    end,
})
