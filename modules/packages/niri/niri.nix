{
  flake.nixosModules.niri = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      wl-clipboard wtype
      xdg-desktop-portal-gtk xdg-desktop-portal-gnome

      grim slurp swappy
      wf-recorder
      brightnessctl

      adw-gtk3
      gnome-themes-extra
      papirus-icon-theme
    ];

    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = { };

    xdg.portal.config = {
      common = {
        default = [
          "gtk"
          "gnome"
        ];
      };
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      maple-mono.truetype
      lato
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hjem.users.eduardo = {
      files = {
        ".config/niri/config.kdl".source = ./niri-config.kdl;
      };
    };

  };
}
