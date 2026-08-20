{
  flake.nixosModules.programming = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      gcc arrow-cpp cmake
      gnumake
      nodejs
      typescript-go
      go delve
      gopls golangci-lint
      cargo rustc
      # python3
      basedpyright ruff
      openjdk
      lua-language-server
      nil nixpkgs-fmt
      yaml-language-server vscode-json-languageserver
      bash-language-server
      sqls
      oracle-instantclient
      claude-code fabric-ai opencode antigravity-cli
    ];

    environment.sessionVariables = {
      ORACLE_HOME = "${pkgs.oracle-instantclient.lib}";
      LD_LIBRARY_PATH = [ "${pkgs.oracle-instantclient.lib}/lib" ];
    };

  };
}
