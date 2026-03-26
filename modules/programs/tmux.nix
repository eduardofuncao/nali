{
  flake.nixosModules.tmux = {pkgs, ...}: {

    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      baseIndex = 1;
    };

  };
}
