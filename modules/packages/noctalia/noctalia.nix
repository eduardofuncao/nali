{inputs, ...}: {

  flake-file.inputs ={
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.nixosModules.noctalia = {pkgs, lib, ...}: {

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      evtest
      bemenu
    ];

    hjem.users.eduardo = {
      files = {
        ".config/noctalia-shell/config.json".source = ./noctalia.json;
      };
    };

  };
}

