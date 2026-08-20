{ lib, ...}: {
  flake.nixosModules.vicinae = { pkgs, ...}: {

    environment.systemPackages = with pkgs; [
      vicinae
    ];

    systemd.user.services.vicinae = {
      description = "Vicinae Launcher Daemon";
      documentation = [ "https://docs.vicinae.com" ];
      after = [ "graphical-session.target" ];
      bindsTo = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      environment = {
        USE_LAYER_SHELL = "1";
        PATH = lib.mkForce "/run/current-system/sw/bin:${lib.makeBinPath [ pkgs.vicinae ]}";
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.vicinae}/bin/vicinae server --replace";
        Restart = "always";
        RestartSec = "60";
      };
    };

  };
}
