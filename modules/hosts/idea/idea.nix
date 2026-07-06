{ inputs, self, ... }: {
  flake.nixosConfigurations.idea = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      idea
    ];
  };


  flake.nixosModules.idea = {pkgs, ...}: {
    imports = with self.nixosModules; [
      hjem
      stylix

      # services
      audio graphics kanata
      udev
      # neru
      greetd
      docker
      vicinae

      # packages
      core
      swap
      cli
      fish
      niri
      noctalia

      kitty
      tmux
      neovim
      squix
      viewers
      zen helium #affinity

      editing
      programming
      gaming
      work
    ];

  };
}
