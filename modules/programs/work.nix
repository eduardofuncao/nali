{ inputs, ... }:
let
  web-agent-pkg = { pkgs }: pkgs.callPackage ./web-agent.nix {};
in
{
  flake.nixosModules.work = { pkgs, lib, ... }:
  let
    web-agent = web-agent-pkg { inherit pkgs; };
  in {
    environment.systemPackages = with pkgs; [
      dbeaver-bin
      openfortivpn
      maestro
      android-tools
      teams-for-linux
      putty
      steam-run

      web-agent
      (androidenv.emulateApp {
        name = "emulate-android";
        platformVersion = "35";
        abiVersion = "x86_64";
        systemImageType = "google_apis";
      })

    ];

    environment.shellAliases = {
      emulator = ''LIBGL_DRI3_DISABLE=1 NIX_ANDROID_EMULATOR_FLAGS="-gpu host -accel on -no-snapshot -memory 4096 -cores 4 -no-metrics" steam-run run-test-emulator'';
    };

    nixpkgs.config.android_sdk.accept_license = true;

    environment.etc."xdg/applications/web-agent.desktop".text = ''
      [Desktop Entry]
      Name=Web Agent
      Exec=${web-agent}/bin/web-agent
      Icon=${web-agent}/usr/share/icons/hicolor/256x256/apps/web-agent.png
      Comment=Web Agent application
      Categories=Application;
      Type=Application
    '';
  };
}
