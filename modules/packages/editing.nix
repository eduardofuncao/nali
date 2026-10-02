{ ... }: {
  flake.nixosModules.editing = { pkgs, config, ... }: {

    environment.systemPackages = with pkgs; [
      ffmpeg chafa obs-studio
      # inkscape
    ];

  };
}
