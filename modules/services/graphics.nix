{
  flake.nixosModules.graphics = { pkgs, ... }: {

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vulkan-loader
      ];
    };

  };
}


