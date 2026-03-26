{
  flake.nixosModules.editing = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      ffmpeg obs
    ];

  };
}
