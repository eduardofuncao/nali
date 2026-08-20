{inputs, ...}: {

  flake-file.inputs ={
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.nixosModules.noctalia = {pkgs, lib, ...}: {

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      evtest
      bemenu
    ];

    services.tuned.enable = true;
    services.upower.enable = true;

    hjem.users.eduardo = {
      files = {
        ".config/noctalia-shell/config.toml".source = ./noctalia.toml;
      };
    };

  };
}

