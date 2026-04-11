{
  flake.nixosModules.ssh = {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        X11Forwarding = false;
      };
    };

    # TODO: add SSH public key
    # users.users.eduardo.openssh.authorizedKeys.keys = [ ];
  };
}
