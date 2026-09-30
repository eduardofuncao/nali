vim.pack.add({
  "https://github.com/dont-be-evil-company/kulala.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim"
})

-- Resolve kulala-core license token at runtime via secretspec (lua-only).
if (vim.env.KULALA_CORE_LICENSE_TOKEN == nil or vim.trim(vim.env.KULALA_CORE_LICENSE_TOKEN) == "")
  and vim.fn.executable("secretspec") == 1
then
  local spec = vim.fn.stdpath("config") .. "/secretspec.toml"
  if vim.fn.filereadable(spec) == 1 then
    -- --reason: secretspec requires an access reason by default; without it
    -- `get` fails and the token silently stays unset.
    local out = vim.fn.system({
      "secretspec",
      "-f",
      spec,
      "--reason",
      "kulala.nvim kulala-core download",
      "get",
      "KULALA_CORE_LICENSE_TOKEN",
    })
    if vim.v.shell_error == 0 then
      local token = vim.trim(out)
      if token ~= "" then vim.env.KULALA_CORE_LICENSE_TOKEN = token end
    end
  end
end

require("kulala").setup({
  global_keymaps = true,
  global_keymaps_prefix = "<leader>r",
  kulala_core = {
    path = nil,
    download_tool = "curl",
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

-- Run the auto-downloaded kulala-core via steam-run
local Backend = require("kulala.backend")
local Bridge = require("kulala.cmd.kulala_core_bridge")
if vim.fn.executable("steam-run") == 1 then
  local real = Backend.get_bin_path()
  local shim = Backend.get_bin_dir() .. "/kulala-core-steam-run"
  local f = io.open(shim, "w")
  if f then
    f:write('#!/bin/sh\nexec steam-run "' .. real .. '" "$@"\n')
    f:close()
    vim.fn.system({ "chmod", "+x", shim })
    if vim.fn.executable(shim) == 1 then
      local shim_path = vim.fn.exepath(shim)
      Bridge.executable_path = function()
        return shim_path
      end
      Bridge.require_enabled = function()
        return shim_path
      end
    end
  end
end

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('render-markdown').setup({
    file_types = { 'markdown', 'kulala_ui' },
})
