{
  flake.nixosModules.programming = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      gcc
      arrow-cpp
      gnumake
      cmake
      nodejs
      go
      cargo rustc
      delve
      python3
      openjdk
      gopls
      golangci-lint
      lua-language-server
      pyright
      nil
      nixpkgs-fmt
      lua-language-server
      # oracle-instantclient
      claude-code fabric-ai
    ];

  };
}
