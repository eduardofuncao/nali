{
  flake.nixosModules.kitty = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      kitty
    ];

    hjem.users.eduardo = {
      files = {
        ".config/kitty/kitty.conf".source = ./kitty.conf;
      };
    };

  };
}
