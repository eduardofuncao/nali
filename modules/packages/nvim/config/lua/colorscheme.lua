vim.pack.add({
  "https://github.com/vague-theme/vague.nvim",
})

require("vague").setup({
  transparent = true,
})

vim.cmd.colorscheme("vague")

require("spotlight").setup()
