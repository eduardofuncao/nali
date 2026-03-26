{
  flake.nixosModules.audio = { pkgs, ... }: {

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
    };
    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs; [
      pavucontrols
      # alsa-utils
      # wireplumber
      blueman
    ];

  };
}
