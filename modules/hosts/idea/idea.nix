{ inputs, self, lib, ... }: {
  flake.nixosConfigurations.idea = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      idea

      # services
      audio graphics docker kanata greetd

      # packages
      core
      cli
      viewers
      # hyprland
      # kitty
      niri
      noctalia
      zen
    ];
  };

  flake.nixosModules.idea = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vim
    ];

  };
}
