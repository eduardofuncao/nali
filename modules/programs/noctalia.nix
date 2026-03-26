{
  flake.nixosModules.noctalia = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      noctalia-shell
      evtest
      bemenu
    ];
  };
}
