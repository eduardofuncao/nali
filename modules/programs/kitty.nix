{
  flake.nixosModules.kitty = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      kitty
    ];

  };
}
