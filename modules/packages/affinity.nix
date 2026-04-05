{inputs, ...}: {
  flake-file.inputs.affinity = {
    url = "github:mrshmllow/affinity-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.affinity = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.affinity.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
