local set = vim.opt

-- Line numbers
set.number = true
set.relativenumber = true

set.showmode = false -- Hide mode
set.mouse = "a" -- Mouse for resizing splits
set.clipboard = "unnamedplus" -- Clipboard
set.breakindent = true -- Enable break indent
set.signcolumn = "yes" -- Always have signcolumn
set.updatetime = 250 -- Update time for writing to SWAP
set.timeoutlen = 300 -- Timeout for which-key
set.inccommand = "split" -- Show search and replace in a split
set.cursorline = true -- Show cursorline
set.scrolloff = 10 -- Screen padding
set.hlsearch = true -- Highlight searches
vim.diagnostic.enable() -- enable diagnostics

-- Tabs
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

-- Searching
set.ignorecase = true
set.smartcase = true

-- Splits
set.splitright = true
set.splitbelow = true

-- Whitespace
set.list = true
set.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
