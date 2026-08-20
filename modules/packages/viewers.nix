{
  flake.nixosModules.viewers = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      zathura
      imv
      aerc

      yt-dlp
      spotify-player

      (pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          modernz
          cut
          occivink.crop
        ];
      })
    ];

  };
}
