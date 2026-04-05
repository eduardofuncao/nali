{ self, ... }: {
  flake.nixosModules.editing = { pkgs, ... }: {
    imports = with self.nixosModules; [
      # affinity
    ];

    environment.systemPackages = with pkgs; [
      ffmpeg obs-studio
    ];

  };
}
