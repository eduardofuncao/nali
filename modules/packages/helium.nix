{inputs, ...}: {
  flake-file.inputs.helium = {
    url = "github:AlvaroParker/helium-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.helium = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
