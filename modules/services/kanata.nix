{
  flake.nixosModules.kanata = { pkgs, ... }: {

    environment.systemPackages = [ pkgs.kanata ];

    systemd.services.kanata = {
      description = "Kanata keyboard remapper";
      documentation = [ "https://github.com/jtroo/kanata" ];

      wantedBy = [ "default.target" ];
      wants = [ "display-manager.service" ];
      after = [ "display-manager.service" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kanata}/bin/kanata --cfg /home/eduardo/.config/kanata/config.kbd";
        ExecReload = "${pkgs.util-linux}/bin/kill -HUP $MAINPID";
        Restart = "always";
        RestartSec = 3;
      };

      enable = true;
    };

    hjem.users.eduardo = {
      files = {
        ".config/kanata/config.kbd".text = ''
          ;; Kanata configuration
          ;; Swap Esc and CapsLock

          (defcfg
            process-unmapped-keys yes
          )

          (defsrc
            caps esc
          )

          (deflayer base
            esc caps
          )
        '';
      };
    };

  };
}
