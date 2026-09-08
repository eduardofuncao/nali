{
  flake.nixosModules.podman = { pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true; # docker alias
      defaultNetwork.settings.dns_enabled = true;
    };
    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
