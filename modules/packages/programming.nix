{
  flake.nixosModules.programming = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      gcc
      arrow-cpp
      gnumake
      cmake
      nodejs
      nodePackages.npm
      go
      delve
      python3
      openjdk
      gopls
      lua-language-server
      pyright
      nil
      nixpkgs-fmt
      lua-language-server
      oracle-instantclient
    ];

  };
}
