{
  flake.nixosModules.programming = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      gcc arrow-cpp cmake
      gnumake
      nodejs
      typescript
      go delve
      cargo rustc
      # python3
      pyright
      openjdk
      gopls golangci-lint
      lua-language-server
      nil nixpkgs-fmt
      # oracle-instantclient
      claude-code fabric-ai opencode
    ];

  };
}
