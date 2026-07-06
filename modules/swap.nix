{ ... }: {
  flake.nixosModules.swap = {pkgs, ...}: {

    swapDevices = [{
      device = "/var/lib/swapfile";
      size = 4*1024;
    }];

    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
    ];

  };
}
