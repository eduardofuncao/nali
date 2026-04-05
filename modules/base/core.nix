{
  flake.nixosModules.core = { pkgs, ... }: {

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_TIME = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
    };
    console.keyMap = "br-abnt2";

    services.xserver = {
      xkb.layout = "br";
      xkb.variant = "abnt2";
      xkb.options = "caps:swapescape";
    };

    users.defaultUserShell = pkgs.fish;

    programs.fish = {
      enable = true;
    };

    users.users.eduardo = {
      isNormalUser = true;
      initialPassword = "test";
      description = "Eduardo";
      extraGroups = [ "wheel" "networkmanager" "docker"];
    };

    hjem.users = {
      eduardo = {
        user = "eduardo";
        directory = "/home/eduardo";
      };
    };

    environment.systemPackages = with pkgs; [
      neovim
      git
      curl
      wget
    ];

    system.stateVersion = "25.05";

  };
}
