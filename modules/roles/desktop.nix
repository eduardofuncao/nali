{
  flake.nixosModules.desktop = { self, pkgs, ... }: {
    imports = [
      self.nixosModules.audio
      self.nixosModules.graphics
      self.nixosModules.docker
      self.nixosModules.kanata
    ];

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };
    environment.systemPackages = with pkgs; [
      mpv zathura imv pavucontrol
    ];

  };
}
