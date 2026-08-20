vim.pack.add({ "https://github.com/eduardofuncao/squix.nvim" })

require("squix").setup({
      hide_query = true,
      term_keymaps = true,
      window = {
        position = "botright",
        split_ratio = 0.4,
        auto_focus = true,
        float = { width = "80%", height = "80%", row = "center", col = "center", relative = "editor", border = "rounded" },
      },
      keymaps = {
        run             = "<leader>sr",
        run_named_query = "<leader>sn",
        add             = "<leader>sa",
        switch          = "<leader>ss",
        init            = false,
        status          = "<leader>st",
        tables          = false,
      },
    })
