{
  flake.nixosModules.hyprland = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
    programs.hyprland.enable = true;
  };
}
