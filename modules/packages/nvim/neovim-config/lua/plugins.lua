require("mason").setup()

require("neoscroll").setup({ duration_multiplier = 0.3 })

require("mini.pick").setup()
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Search by grep" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Search help fils" })
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Search buffers" })

require("mini.files").setup()
-- require("mini.pairs").setup()

require("mini.surround").setup()

require("eyeliner").setup({
  highlight_on_key = true,
  dim = true,
})

require("love2d").setup({
  path_to_love_bin = "love",
  restart_on_save = false,
  debug_window_opts = nil,
  setup_makeprg = true,
  identify_love_projects = true
})

vim.g.copilot_enabled = 0
require("avante").setup({
  provider = "glm",
  auto_suggestions_provider = "glm",
  providers = {
    glm = {
      endpoint = "https://api.z.ai/api/coding/paas/v4",
      model = "GLM-4.7",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        reasoning_effort = "medium",  -- low|medium|high, only used for reasoning models
      },
    },
  },
  behaviour = {
    support_paste_from_clipboard = true,
    auto_suggestions = false,
  },
  windows = {
    ask = {
      floating = false, -- Open prompts in floating window instead of sidebar
    },
  },
})
