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
      audio graphics warpd #kanata
      greetd
      docker
      vicinae

      # packages
      core
      cli
      niri
      noctalia

      kitty
      tmux
      neovim
      squix
      viewers
      zen helium

      editing
      programming
      # gaming
      work
    ];

  };
}
