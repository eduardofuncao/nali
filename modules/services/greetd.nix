{
  flake.nixosModules.greetd = { self, inputs, pkgs, ... }: {

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --greeting '★·.·´¯`·.·★·.·´¯`·.·★·.·´¯`·.·★·.·´¯`·.·★' --asterisks --remember --time --cmd niri-session";
        user = "greeter";
      };
    };

  };
}
