{
  flake.nixosModules.docker = { pkgs, ... }: {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      daemon.settings = {
        default-address-pools = [
          { base = "172.80.0.0/16"; size = 24; }
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
