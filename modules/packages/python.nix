{
  flake.nixosModules.python = { pkgs, ... }: {

    environment = {
      localBinInPath = true;
      systemPackages = with pkgs; [
        uv
      ];
    };

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ];
    };

  };
}
