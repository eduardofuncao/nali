{
  flake.nixosModules.core-vm = { pkgs, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;

    environment.variables.EDITOR = "vim";

    environment.systemPackages = with pkgs; [
      # neovim
      vim
      # git
      curl
      wget
    ];

    users.groups.vm = { };
    users.users.vm = {
      isNormalUser = true;
      initialPassword = "test";
      group = "vm";
      extraGroups = [ "wheel" "networkmanager" "docker"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICHKes69jlYokR99MIwLeQ61F8cTE+TXsky4Kl3hfllI ideapad3"
      ];
    };
  };
}
