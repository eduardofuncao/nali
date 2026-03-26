{
  flake.nixosModules.viewers = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      mpv zathura imv
    ];

  };
}
