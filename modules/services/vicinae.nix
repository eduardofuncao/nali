{inputs, ...}: {
  # flake-file.inputs.vicinae = {
  #   url = "github:vicinaehq/vicinae";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };
  flake.nixosModules.vicinae = { pkgs, ...}: {

    environment.systemPackages = with pkgs; [
      vicinae
    ];

    systemd.user.services.vicinae = {
      description = "Vicinae server daemon";
      documentation = [ "https://docs.vicinae.com" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      bindsTo = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        # ExecStart = "${inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/vicinae server";
        ExecStart = "vicinae server";
        Restart = "always";
        RestartSec = "5";
        KillMode = "process";
        Environment = [
          "USE_LAYER_SHELL=1"
          "PATH=/run/current-system/sw/bin:${pkgs.coreutils}/bin:${pkgs.findutils}/bin"
        ];
      };
    };

  };
}
