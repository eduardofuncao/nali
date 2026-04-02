{inputs, lib, ...}: {
  flake-file.inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.neovim = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    hjem.users.eduardo = {
      files = {
        ".config/nvim/init.lua".source = ./config/init.lua;
        ".config/nvim/lua/plugins.lua".source = ./config/lua/plugins.lua;
        ".config/nvim/lua/todo.lua".source = ./config/lua/todo.lua;
        ".config/nvim/lua/git_config.lua".source = ./config/lua/git_config.lua;
        ".config/nvim/lua/treesitter.lua".source = ./config/lua/treesitter.lua;
        ".config/nvim/lua/debugconfig.lua".source = ./config/lua/debugconfig.lua;
        ".config/nvim/lua/oil_config.lua".source = ./config/lua/oil_config.lua;
        ".config/nvim/lua/lsp.lua".source = ./config/lua/lsp.lua;
        ".config/nvim/lua/image.lua".source = ./config/lua/image.lua;
        ".config/nvim/syntax/advpl.vim".source = ./config/syntax/advpl.vim;
        ".config/nvim/nvim-pack-lock.json".source = ./config/nvim-pack-lock.json;
      };
    };
  };
}
