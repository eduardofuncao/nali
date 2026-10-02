{
  flake.nixosModules.audio = { pkgs, ... }: {

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs; [
      pavucontrol
      # alsa-utils
      # wireplumber
      blueman
    ];

  };
}
