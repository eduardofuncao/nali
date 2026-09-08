-- lsp
vim.lsp.enable({ "basedpyrigth", "ruff", "bashls", "gopls", "jsonls", "lua_ls", "nil_ls", "tsc", "yamlls", "sqls" })

vim.diagnostic.config({ virtual_text = true })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "grq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition)

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})
