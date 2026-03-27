--===============
-- NVIM CONFIG ==
--===============

-------------
-- options --
-------------
vim.o.number = true
vim.o.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.o.scrolloff = 6

vim.o.wrap = false
vim.o.breakindent = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.o.swapfile = false
-- vim.o.updatetime = 250
vim.o.undofile = true
vim.o.confirm = true

vim.g.have_nerd_font = true
vim.o.mouse = "a"

-- case insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split" --substitution live preview

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.timeoutlen = 1000

vim.g.netrw_banner = 0          -- hide the banner at the top
vim.g.netrw_liststyle = 3       -- tree view (0=thin, 1=long, 2=wide, 3=tree)
vim.g.netrw_browse_split = 4    -- open files in: 1=hsplit, 2=vsplit, 3=tab, 4=previous window
vim.g.netrw_winsize = 25        -- width of the netrw window (in %)
vim.g.netrw_altv = 1            -- split to the right with :Vex
vim.g.netrw_preview = 1         -- preview window shown in a vertical split
vim.g.netrw_keepdir = 0         -- keep current dir in sync with netrw dir

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- Explicitly set wl-clipboard as the provider
vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste --no-newline',
    ['*'] = 'wl-paste --no-newline',
  },
  cache_enabled = 0,
}

-------------
-- keymaps --
-------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

vim.keymap.set({ "n", "v", "x" }, "[b", ":bp<CR>")
vim.keymap.set({ "n", "v", "x" }, "]b", ":bn<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>tn", ":tabnew<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>tc", ":tabclose<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>ba", ":e #<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>sb", ":sf #<CR>")


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear search highlights when pressing <esc>

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "grq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "grd", vim.lsp.buf.definition)

vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Open filebexplorer" })

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
-- vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')

vim.keymap.set({'n', 'x', 'o'}, 'ss', '<Plug>(leap)', { desc = 'Leap' })
vim.keymap.set('n', 'sS', '<Plug>(leap-from-window)', { desc = 'Leap (all windows)' })

-------------
-- plugins --
-------------
vim.pack.add({
  { src = "https://github.com/sainnhe/everforest" },
  { src = "https://github.com/vague-theme/vague.nvim"},
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = "https://github.com/L3MON4D3/LuaSnip" },

  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/jbyuki/one-small-step-for-vimkind' },
  { src = 'https://github.com/leoluz/nvim-dap-go' },
  { src = 'https://github.com/miroshQa/debugmaster.nvim' },

  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.files" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.ai" },
  { src = "https://github.com/stevearc/oil.nvim" },
  -- { src = "https://github.com/echasnovski/mini.pairs" },

  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/HakonHarnes/img-clip.nvim" },

  { src = "https://github.com/yetone/avante.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },

  -- { src = "https://github.com/zbirenbaum/copilot.lua" },
  -- { src = "https://github.com/copilotlsp-nvim/copilot-lsp" },

  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/sindrets/diffview.nvim" },

  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },

  { src = 'https://github.com/jinh0/eyeliner.nvim' },
  { src = 'https://codeberg.org/andyg/leap.nvim' },

  { src = 'https://github.com/S1M0N38/love2d.nvim' },
})

-------------------
-- plugins setup --
-------------------
require("plugins")

----------------
-- treesitter --
----------------
require("treesitter")

---------
-- lsp --
---------
require("lsp")

---------
-- git --
---------
require("git_config")

---------
-- oil --
---------
require("oil_config")

-----------
-- debug --
-----------
require("debugconfig")

------------
-- images --
------------
require("image")

require("todo")

-- spellcheck
vim.opt.spelllang = { "en_us", "pt_br" }

-----------------
-- colorscheme --
-----------------
vim.g.everforest_background = "soft" -- 'hard', 'medium', 'soft'
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_disable_italic_comment = 0
vim.g.everforest_transparent_background = 1

require("vague").setup({
  transparent = true,
})

vim.cmd.colorscheme("vague")

vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#E0A4BA', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#725973', underline = true })
