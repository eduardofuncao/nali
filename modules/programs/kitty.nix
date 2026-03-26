{
  flake.nixosModules.kitty = { pkgs, lib, ... }: {

    programs.kitty = {
      enable = true;
    };

  };
}
