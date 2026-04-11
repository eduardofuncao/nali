{
  flake.nixosModules.core-vm = {
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
