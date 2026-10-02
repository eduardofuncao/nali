{inputs, ...}: {
  flake-file.inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
    # inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.neovim = {pkgs, lib, ...}: {

    programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    environment.systemPackages = [
      pkgs.tree-sitter
      pkgs.secretspec
    ];

    # NOTE: whole-dir symlink does NOT work here: vim.pack hardcodes its
    # lockfile at <config>/nvim-pack-lock.json and hard-errors (E5113) when
    # it cannot write it, so ~/.config/nvim must stay a real directory.
    # New files under config/{lua,lsp}/ are picked up automatically via
    # readDir below (still needs `git add` for flake visibility).
    hjem.users.eduardo = let
      cfgDir = ./config;
      linkDir = sub:
        lib.mapAttrs' (name: _: {
          name = ".config/nvim/${sub}/${name}";
          value.source = cfgDir + "/${sub}/${name}";
        }) (builtins.readDir (cfgDir + "/${sub}"));
    in {
      files =
        {
          ".config/nvim/init.lua".source = cfgDir + "/init.lua";
          ".config/nvim/secretspec.toml".source = cfgDir + "/secretspec.toml";
        }
        // linkDir "lua"
        // linkDir "lsp";
    };
  };
}
