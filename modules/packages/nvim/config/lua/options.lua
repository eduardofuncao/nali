-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.laststatus = 3
vim.o.scrolloff = 6
vim.o.wrap = false
vim.o.breakindent = true
vim.o.winborder = "rounded"
vim.o.pumheight = 15

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.undofile = true
vim.o.autoread = true
vim.o.mouse = "a"
vim.o.confirm = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split" -- substitution live preview
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.splitright = true
vim.o.splitbelow = true

require('vim._core.ui2').enable()
