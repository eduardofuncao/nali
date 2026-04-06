<img width="881" height="178" alt="image" src="https://github.com/user-attachments/assets/f6c5f7ad-d7bb-4e3b-8800-2d09e1046cf9" />

# nali 
> nasin lili pi ilo nanpa

A minimal nixos configuration example using the dendritic patter with [flake-parts](https://github.com/hercules-ci/flake-parts), [flake-file](https://github.com/vic/flake-file) and [hjem](https://github.com/feel-co/hjem). Using niri-wm and noctalia-shell

If you'd like to know more about the dendritic pattern for you nixos configuration, read [doc-steve's guide](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/tree/main/modules), and [filip-ruman's practical implementation tips](https://filip-ruman.pages.dev/nixos_config/config_structure/). These were incredibly helpful when I started rewriting my config.

## Configuration entry point and Rebuilding the system
The entry point for building the system is in `modules/hosts/desktop/desktop.nix`. From this file, hardware.nix is sourced and all other modules are imported
To rebuild the system, use `sudo nixos-rebuild switch --flake .#desktop`

If you need to create a configuration for another host, you can add it in `hosts/` following the same structure as `desktop.nix` and build your combining any of the modules

## Adding flake inputs
*flake-file* is used to add flake inputs from the same config file where they will be used. For example, we can see this in the `zen.nix` module:
```nix
{inputs, ...}: {
  flake-file.inputs.zen-browser = {
    url = "github:youwen5/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.zen = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
```
After adding this, flake-file update the flake.nix file using `nix run .#write-flake`

## Sourcing config files without home-manager
To source config files from other programs using nix, we use hjem. For example, this is the tmux module, where we source a tmux.conf file that is located in the same directory as tmux.nix to be available at `~/.config/tmux/tmux.conf` after rebuilding the system:
```nix
{
  flake.nixosModules.tmux = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      baseIndex = 1;
    };

    hjem.users.eduardo = {
      files = {
        ".config/tmux/tmux.conf".source = ./tmux.conf;
      };
    };
  };
}
```

> made with `olin` by eduardofuncao
