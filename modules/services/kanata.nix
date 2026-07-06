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
          (defcfg
            process-unmapped-keys yes
            concurrent-tap-hold yes
            ;; TODO: enable when kanata 1.12+ lands in nixpkgs
            ;; tap-hold-require-prior-idle 150
            linux-dev-names-include ("AT Translated Set 2 keyboard")
          )

          ;; TODO: enable when kanata 1.12+ lands in nixpkgs
          ;; (defhands
          ;;   (left  q w e r t a s d f g z x c v b)
          ;;   (right y u i o p h j k l ; n m , . /)
          ;; )

          (defsrc
            caps esc
            a s d f j k l ;
          )

          (defalias
            ;; TODO: switch to tap-hold-opposite-hand with defhands
            hlctl (tap-hold 200 200 d lctl)
            hlalt (tap-hold 200 200 s lalt)
            hlmet (tap-hold 200 200 a lmet)
            hlsft (tap-hold 200 200 f lsft)
            hrsft (tap-hold 200 200 j rsft)
            hrmet (tap-hold 200 200 ; rmet)
            hralt (tap-hold 200 200 l ralt)
            hrctl (tap-hold 200 200 k rctl)
          )

          (deflayer base
            esc caps
            @hlmet @hlalt @hlctl @hlsft @hrsft @hrctl @hralt @hrmet
          )
        '';
      };
    };

  };
}
