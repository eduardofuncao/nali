{
  flake.nixosModules.gaming = { pkgs, ... }: {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
          ioprio = "high";
        };
        gpu = {
          apply_gpu_optimisations = 0; # Intel iGPU doesn't support this
        };
      };
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      protontricks.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    hardware.steam-hardware.enable = true;

    hardware.graphics.extraPackages = with pkgs; [
      dxvk
      vkd3d-proton
    ];

    environment.systemPackages = with pkgs; [
      mangohud
      gamescope
      hydralauncher
    ];

    boot.kernelParams = [
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "i915.enable_dc=0"
      "i915.enable_psr=0"
      "split_lock_detect=off"
      "transparent_hugepage=madvise"
    ];

    boot.kernel.sysctl."vm.max_map_count" = 2147483642;

    services.thermald.enable = true;
  };
}
