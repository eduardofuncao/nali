{ inputs, self, lib, ... }:
{
  flake.nixosConfigurations.venus = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      venus
    ];
  };

  flake.nixosModules.venus = { pkgs, ... }: {
    imports = with self.nixosModules; [
      hjem
      core
      cli
      docker
      ssh
      caddy
      postgresql
      squix
    ];

    networking.networkmanager.enable = lib.mkForce false;
    console.keyMap = lib.mkForce "us";

    virtualisation.vmVariant = {
      imports = with self.nixosModules; [ core-vm ];

      programs.starship.enable = true;

      virtualisation.memorySize = 6144;
      virtualisation.diskSize = 10240;
      virtualisation.cores = 2;
      virtualisation.graphics = true;
      console.font = "latarcyrheb-sun32";
      virtualisation.forwardPorts = [
        { from = "host"; host.port = 2222; guest.port = 22; }
        { from = "host"; host.port = 8080; guest.port = 80; }
        { from = "host"; host.port = 5433; guest.port = 5432; }
      ];
    };
  };
}
