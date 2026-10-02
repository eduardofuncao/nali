-- Write and quit
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q<cr>", { silent = true })
vim.keymap.set("n", "<leader>a", ":e #<cr>", { silent = true })

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Move to right split" })

-- Clear multicursors (<C-l> is taken by split nav; same wipe as |CTRL-L-default|)
vim.keymap.set("n", "<C-q>", function()
  vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_create_namespace("nvim.multicursor"), 0, -1)
end, { silent = true, desc = "Clear multicursors" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- vim.o.clipboard = 'unnamedplus'
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')

vim.keymap.set({ "n", "v", "x" }, "[b", ":bp<CR>")
vim.keymap.set({ "n", "v", "x" }, "]b", ":bn<CR>")
