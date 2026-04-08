{ inputs, ... }:
{
  flake.nixosModules.work = { pkgs, lib, ... }:
  {
    imports = [ inputs.self.nixosModules.web-agent ];
    environment.systemPackages = with pkgs; [
      dbeaver-bin
      openfortivpn
      maestro
      android-tools
      teams-for-linux
      putty
      steam-run
      bruno

      httptoolkit
      scrcpy
      (androidenv.emulateApp {
        name = "emulate-android";
        platformVersion = "35";
        abiVersion = "x86_64";
        systemImageType = "google_apis";
      })

    ];

    virtualisation.waydroid.enable = true;
    networking.nftables.enable = true;

    environment.shellAliases = {
      emulator = ''LIBGL_DRI3_DISABLE=1 NIX_ANDROID_EMULATOR_FLAGS="-gpu host -accel on -no-snapshot -memory 4096 -cores 4 -no-metrics" steam-run run-test-emulator'';
    };

    nixpkgs.config.android_sdk.accept_license = true;

    # programs.fish.shellInit = ''
    #   # Oracle Instant Client
    #   set -gx ORACLE_HOME "${pkgs.oracle-instantclient.lib}"
    #   # Add Oracle libraries to LD_LIBRARY_PATH
    #   if set -q LD_LIBRARY_PATH
    #     set -gx LD_LIBRARY_PATH "${pkgs.oracle-instantclient.lib}/lib:$LD_LIBRARY_PATH"
    #   else
    #     set -gx LD_LIBRARY_PATH "${pkgs.oracle-instantclient.lib}/lib"
    #   end
    #
    #   # Electron/Wayland
    #   set -gx ELECTRON_OZONE_PLATFORM_HINT auto
    # '';
  };
}
