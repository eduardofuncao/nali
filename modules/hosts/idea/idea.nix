{ inputs, self, ... }: {
  flake.nixosConfigurations.idea = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      idea
      hjem
      stylix

      # services
      audio graphics kanata
      greetd
      docker
      vicinae

      # packages
      core
      cli
      viewers
      niri
      noctalia

      kitty
      tmux
      neovim
      zen

      editing
      programming
      # gaming
      work
    ];
  };


  flake.nixosModules.idea = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
    ];

  };
}
