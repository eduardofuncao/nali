{ inputs, ... }:
{
  flake.nixosModules.work = { pkgs, lib, ... }:
  let
    android-sdk = pkgs.androidenv.composeAndroidPackages {
      platformVersions = [ "35" ];
      systemImageTypes = [ "google_apis" ];
      abiVersions = [ "x86_64" ];
      includeEmulator = true;
      includeSystemImages = true;
    };
  in {
    imports = [ inputs.self.nixosModules.web-agent ];

    environment.systemPackages = with pkgs; [
      dbeaver-bin
      openfortivpn
      android-tools
      teams-for-linux
      putty
      steam-run
      bruno
      chromium
      firefox
      redis

      httptoolkit
      scrcpy
      android-studio
      android-sdk.androidsdk

    ];

    environment.sessionVariables.ANDROID_SDK_ROOT = "${android-sdk.androidsdk}/libexec/android-sdk";
    environment.sessionVariables.ANDROID_HOME = "${android-sdk.androidsdk}/libexec/android-sdk";



    virtualisation.waydroid.enable = true;
    networking.nftables.enable = true;


    nixpkgs.config.android_sdk.accept_license = true;

  };
}
