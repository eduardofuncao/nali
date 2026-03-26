{
  flake.nixosModules.vmbuild = { pkgs, ... }: {

    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;

    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_TIME = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
    };
    console.keyMap = "br-abnt2";

    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;

    users.users.eduardo = {
      isNormalUser = true;
      initialPassword = "test";
      description = "Eduardo";
      extraGroups = [ "wheel" "networkmanager" ];
    };

    environment.systemPackages = with pkgs; [
      neovim git curl wget
    ];

    system.stateVersion = "25.05";

  };
}
