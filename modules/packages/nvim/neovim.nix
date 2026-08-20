{inputs, ...}: {
  flake-file.inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.neovim = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
      # pkgs.neovim
      pkgs.tree-sitter
    ];

    hjem.users.eduardo = {
      files = {
        ".config/nvim/init.lua".source = ./config/init.lua;

        ".config/nvim/lua/options.lua".source = ./config/lua/options.lua;
        ".config/nvim/lua/keymaps.lua".source = ./config/lua/keymaps.lua;
        ".config/nvim/lua/lsp-config.lua".source = ./config/lua/lsp-config.lua;
        ".config/nvim/lua/mini.lua".source = ./config/lua/mini.lua;
        ".config/nvim/lua/completion.lua".source = ./config/lua/completion.lua;
        ".config/nvim/lua/colorscheme.lua".source = ./config/lua/colorscheme.lua;
        ".config/nvim/lua/spotlight.lua".source = ./config/lua/spotlight.lua;
        ".config/nvim/lua/api.lua".source = ./config/lua/api.lua;
        ".config/nvim/lua/sql.lua".source = ./config/lua/sql.lua;
        ".config/nvim/lua/git.lua".source = ./config/lua/git.lua;
        ".config/nvim/lua/treesitter.lua".source = ./config/lua/treesitter.lua;

        ".config/nvim/lsp/basedpyrigth.lua".source = ./config/lsp/basedpyrigth.lua;
        ".config/nvim/lsp/bashls.lua".source = ./config/lsp/bashls.lua;
        ".config/nvim/lsp/gopls.lua".source = ./config/lsp/gopls.lua;
        ".config/nvim/lsp/jsonls.lua".source = ./config/lsp/jsonls.lua;
        ".config/nvim/lsp/lua_ls.lua".source = ./config/lsp/lua_ls.lua;
        ".config/nvim/lsp/nil_ls.lua".source = ./config/lsp/nil_ls.lua;
        ".config/nvim/lsp/ruff.lua".source = ./config/lsp/ruff.lua;
        ".config/nvim/lsp/sqls.lua".source = ./config/lsp/sqls.lua;
        ".config/nvim/lsp/tsc.lua".source = ./config/lsp/tsc.lua;
        ".config/nvim/lsp/yamlls.lua".source = ./config/lsp/yamlls.lua;
      };
    };
  };
}
