{
  flake.nixosModules.fish = { pkgs, ... }: {

    programs.fish.enable = true;

    hjem.users.eduardo = {
      files = {
        ".config/fish/config.fish".source = ./config.fish;
        ".config/fish/completions/squix.fish".source = ./completions/squix.fish;
        ".config/fish/functions/doix.fish".source = ./functions/doix.fish;
        ".config/fish/functions/emulator.fish".source = ./functions/emulator.fish;
        ".config/fish/functions/task.fish".source = ./functions/task.fish;
      };
    };

  };
}
