{ inputs, self, ... }: {
  flake.nixosConfigurations.idea = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      idea

      # services
      audio graphics kanata greetd
      docker
      vicinae

      # packages
      core
      cli
      viewers
      niri
      # hyprland

      kitty
      tmux
      neovim
      noctalia
      zen

      editing
      programming
      # gaming
      # work
    ];
  };


  flake.nixosModules.idea = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
    ];

  };
}
