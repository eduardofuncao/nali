{ inputs, self, lib, ... }: {
  flake.nixosConfigurations.idea = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      base
      idea
      laptop
      cli
      hyprland
      kitty
      niri
      noctalia
      zen
    ];
  };

  nixosModules.idea = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vim
    ];

  };
}
