{
  flake.nixosModules.greetd = { self, inputs, pkgs, ... }: {

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };

  };
}
