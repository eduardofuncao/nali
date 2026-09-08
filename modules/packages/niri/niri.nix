{
  flake.nixosModules.niri = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      wl-clipboard
      xdg-desktop-portal-gtk xdg-desktop-portal-gnome
      xwayland-satellite

      grim slurp swappy wayscriber
      wl-kbptr
      wf-recorder
      brightnessctl

      adw-gtk3
      gnome-themes-extra
      papirus-icon-theme
    ];

    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    xdg.portal.config = {
      common = {
        default = [
          "gtk"
          "gnome"
        ];
      };
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hjem.users.eduardo = {
      files = {
        ".config/niri/config.kdl".source = ./niri-config.kdl;
        ".config/wl-kbptr/config".source = ./wl-kbptr-config;
      };
    };

  };
}
