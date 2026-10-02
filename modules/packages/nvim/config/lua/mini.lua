vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})


require("mini.surround").setup()
require("mini.ai").setup()
require("mini.splitjoin").setup({ mappings = {toggle = 'gj'} })
require("mini.jump").setup()

require("mini.pick").setup()
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Search files" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Search by grep" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Search help fils" })
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Search buffers" })

require("mini.files").setup()
vim.keymap.set("n", "<leader>e", function ()
  local MiniFiles = require("mini.files")
  local _ = MiniFiles.close()
    or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  vim.schedule(function()
    MiniFiles.reveal_cwd()
  end)
end, { desc = "Open file explorer" })

require("mini.animate").setup({
  cursor = { enable = false },
  scroll = {
    enable = true,
    timing = require("mini.animate").gen_timing.linear({ duration = 50, unit = "total" }),
    subscroll = require("mini.animate").gen_subscroll.equal({ max_output_steps = 60 }),
  },
  resize = { enable = false },
  open = { enable = false },
  close = { enable = false },
})

require("mini.icons").setup()
