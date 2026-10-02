vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
})

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),
    gen_loader.from_lang(),
  },
})

require('mini.completion').setup({
  delay = { completion = 10000000, info = 100, signature = 50 },
})
