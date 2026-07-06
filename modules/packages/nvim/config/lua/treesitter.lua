----------------
-- treesitter --
----------------
require("nvim-treesitter").install({
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "python",
  "go",
  "javascript",
  "html",
  "css",
  "json",
  "yaml",
  "markdown",
  "nix",
  "robot",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c", "lua", "vim", "vimdoc", "query",
    "python", "go", "javascript", "html", "css",
    "json", "yaml", "nix", "robot",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

-- textobjects
require("nvim-treesitter-textobjects").setup({
  move = {
    set_jumps = true,
  },
})

local move = require("nvim-treesitter-textobjects.move")
vim.keymap.set("n", "]f", function() move.goto_next_start("@function.outer") end)
vim.keymap.set("n", "]c", function() move.goto_next_start("@class.outer") end)
vim.keymap.set("n", "]a", function() move.goto_next_start("@parameter.inner") end)
vim.keymap.set("n", "]k", function() move.goto_next_start("@block.outer") end)
vim.keymap.set("n", "]F", function() move.goto_next_end("@function.outer") end)
vim.keymap.set("n", "]C", function() move.goto_next_end("@class.outer") end)
vim.keymap.set("n", "]A", function() move.goto_next_end("@parameter.inner") end)
vim.keymap.set("n", "]K", function() move.goto_next_end("@block.outer") end)
vim.keymap.set("n", "[f", function() move.goto_previous_start("@function.outer") end)
vim.keymap.set("n", "[c", function() move.goto_previous_start("@class.outer") end)
vim.keymap.set("n", "[a", function() move.goto_previous_start("@parameter.inner") end)
vim.keymap.set("n", "[k", function() move.goto_previous_start("@block.outer") end)
vim.keymap.set("n", "[F", function() move.goto_previous_end("@function.outer") end)
vim.keymap.set("n", "[C", function() move.goto_previous_end("@class.outer") end)
vim.keymap.set("n", "[A", function() move.goto_previous_end("@parameter.inner") end)
vim.keymap.set("n", "[K", function() move.goto_previous_end("@block.outer") end)

vim.filetype.add({
  extension = {
    prw = "advpl",
    prg = "advpl",
    ch = "c",
  },
})
