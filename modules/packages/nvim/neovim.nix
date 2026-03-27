{inputs, lib, ...}: {
  flake-file.inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.neovim = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    hjem.users.eduardo.files.".config/nvim".source = lib.fileset.toSource {
      root = ./neovim-config;
      fileset = lib.fileset.gitTracked ./neovim-config;
    };
  };
}
