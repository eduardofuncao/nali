require("oil").setup({
  keymaps = {
    -- navigate up/down directories
    ["H"] = { "actions.parent",   mode = "n" },
    ["L"] = { "actions.select",   mode = "n" },
    -- keep defaults intact
    ["-"]    = { "actions.parent", mode = "n" },
    ["<CR>"] = "actions.select",
  },
  use_default_keymaps = true,

  float = {
    padding  = 1,
    max_width  = 0.4,
    max_height = 0.4,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    override = function(conf)
      return conf
    end,
  },
})

vim.api.nvim_create_user_command("Ex", function()
  vim.cmd("Oil")
end,{})

vim.api.nvim_create_user_command("Sex", function()
  vim.cmd("10split")
  vim.cmd("Oil")
end, {})

vim.api.nvim_create_user_command("Vex", function()
  vim.cmd("30vsplit")
  vim.cmd("Oil")
end, {})

vim.api.nvim_create_user_command("Fex", function()
  require("oil").open_float()
end, {})

vim.keymap.set("n", "-", "<cmd>Fex<CR>",  { desc = "Open explorer" })
