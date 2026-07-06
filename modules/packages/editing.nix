{ self, ... }: {
  flake.nixosModules.editing = { pkgs, config, ... }: {

    environment.systemPackages = with pkgs; [
      ffmpeg chafa obs-studio
      # inkscape
    ];

    boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=3 video_nr=2,3,4 card_label="Dog,Hamster,Fish" exclusive_caps=1
      '';

  };
}
