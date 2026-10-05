{ inputs, self, ... }: {
  flake.nixosConfigurations.think = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      think
    ];
  };


  flake.nixosModules.think = {pkgs, ...}: {
    imports = with self.nixosModules; [
      hjem
      stylix

      # services
      audio graphics kanata
      udev
      greetd
      podman #docker
      vicinae

      # packages
      core
      swap
      cli
      fish
      starship
      niri
      noctalia

      kitty
      tmux
      neovim
      squix
      viewers
      zen helium

      editing
      programming python
      # gaming
      # work
    ];

  };
}
