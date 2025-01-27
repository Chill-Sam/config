local map = vim.keymap.set

-- Reset to center of screen on movement
map(
    "n",
    "<C-d>",
    "<C-d>zz",
    { noremap = true, silent = true }
)

map(
    "n", 
    "<C-u>", 
    "<C-u>zz", 
    { noremap = true, silent = true }
)

-- Close highlighting when searching
map(
    "n", 
    "<Esc>",
    "<cmd>nohlsearch<CR>"
)

map(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Show diagnostic [E]rror messages" }
)

local builtin = require('telescope.builtin')
map('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
map("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope search config" })
map("n", '<leader>sc', "<cmd>TodoTelescope<CR>", { desc = 'Telescope search comments' })

map("n", "<leader>f", function()
        require("conform").format({ lsp_fallback = true })
    end, { desc = "Format with Conform" })
