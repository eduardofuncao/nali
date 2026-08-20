vim.pack.add({
  "https://github.com/mistweaverco/kulala.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim"
})

require("kulala").setup({
  global_keymaps = true,
  global_keymaps_prefix = "<leader>r",
  kulala_core = {
    path = vim.fn.exepath("kulala-core"),
  },
  kulala_keymaps = {
    ["Show verbose"] = { "D", function() require("kulala.ui").show_verbose() end },
    ["Previous tab"] = { "<C-p>", function() require("kulala.ui").show_previous_tab() end },
    ["Next tab"] = { "<C-n>", function() require("kulala.ui").show_next_tab() end },
  },
  ui = {
    win_opts = {
      wo = {
        --foldmethod = "manual" 
        wrap = true,
      },
    },
  },
  default_env = "dev",
})

-- kulala.nvim's Backend.binary_exists()/is_up_to_date() only check the
-- auto-download dir (~/.local/share/nvim/kulala.nvim/bin) and ignore
-- kulala_core.path, so the LSP-attach gate bails early when a system binary
-- is used (NixOS). Honor the configured path like the runtime bridge does.
local Backend = require("kulala.backend")
local Bridge = require("kulala.cmd.kulala_core_bridge")
Backend.is_up_to_date = function()
  return Bridge.executable_path() ~= nil
end

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('render-markdown').setup({
    file_types = { 'markdown', 'kulala_ui' },
})
