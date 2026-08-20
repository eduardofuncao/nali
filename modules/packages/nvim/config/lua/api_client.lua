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

require("ufo").setup({
  provider_selector = function(_, filetype, _)
    if filetype == "kulala_ui" then
      return { "lsp", "indent" }
    end
    return ""
  end,
})

-- global, harmless display settings
vim.o.foldcolumn = "auto:3"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.fillchars = {
  foldopen = "▸",
  foldclose = "▾",
  foldsep = " ",
}

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

