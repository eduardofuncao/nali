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
      chromium
      firefox

      httptoolkit
      scrcpy
      (let sdk = androidenv.composeAndroidPackages {
        platformVersions = [ "35" ];
        systemImageTypes = [ "google_apis" ];
        abiVersions = [ "x86_64" ];
      }; in sdk.androidsdk)

    ];

    virtualisation.waydroid.enable = true;
    networking.nftables.enable = true;


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
