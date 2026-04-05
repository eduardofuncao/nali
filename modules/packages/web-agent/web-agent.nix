{
  flake.nixosModules.web-agent = { pkgs, lib, ... }:
  let
    web-agent-unwrapped = pkgs.stdenv.mkDerivation rec {
      pname = "web-agent-unwrapped";
      version = "1.0.0";

      src = ./web-agent.deb;

      nativeBuildInputs = with pkgs; [ dpkg ];

      unpackPhase = ''
        dpkg-deb -x $src .
      '';

      installPhase = ''
        mkdir -p $out
        cp -r opt $out/
        cp -r usr $out/

        chmod +x $out/opt/web-agent/web-agent
        find $out -name "*.so*" -exec chmod +x {} \;
      '';
    };

    web-agent = pkgs.buildFHSEnv {
      name = "web-agent";

      targetPkgs = pkgs: with pkgs; [
        glibc
        stdenv.cc.cc.lib
        glib
        gobject-introspection
        gtk3
        gdk-pixbuf
        cairo
        pango
        atk
        at-spi2-atk
        at-spi2-core
        libx11
        libxext
        libxi
        libxrandr
        libxrender
        libxtst
        libxcomposite
        libxdamage
        libxfixes
        wayland
        libxkbcommon
        dbus
        systemd
        libuuid
        expat
        zlib
        libappindicator-gtk3
        libdbusmenu-gtk3
        alsa-lib
        cups
        libGL
        mesa
        nspr
        nss
        fontconfig
        freetype
        libnotify
        libsecret
        keyutils
        krb5
      ];

      multiPkgs = pkgs: with pkgs; [
        glib
      ];

      extraBuildCommands = ''
        mkdir -p $out/opt/web-agent
        mkdir -p $out/usr/share/applications
        mkdir -p $out/usr/share/icons

        cp -r ${web-agent-unwrapped}/opt/web-agent/* $out/opt/web-agent/
        cp -r ${web-agent-unwrapped}/usr/share/applications/* $out/usr/share/applications/
        cp -r ${web-agent-unwrapped}/usr/share/icons/* $out/usr/share/icons/
      '';

      runScript = pkgs.writeScript "web-agent-runner" ''
        #!/bin/bash

        export GIO_MODULE_DIR=${pkgs.glib-networking}/lib/gio/modules
        export XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"

        cd /opt/web-agent

        exec ./web-agent "$@"
      '';

      meta = with lib; {
        description = "Web Agent application";
        platforms = platforms.linux;
      };
    };
  in {
    environment.systemPackages = [ web-agent ];

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
