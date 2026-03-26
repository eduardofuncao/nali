{
  flake.nixosModules.docker = { pkgs, ... }: {

    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };

  };
}
