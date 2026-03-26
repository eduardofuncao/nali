{
  flake.nixosModules.tmux = {pkgs, ...}: {

    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      baseIndex = 1;
    };


    hjem.users.eduardo = {
      files = {
        ".config/tmux/tmux.conf".source = ./tmux.conf;
      };
    };

  };
}
