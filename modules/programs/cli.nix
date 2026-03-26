{
  flake.nixosModules.cli = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      starship
      git
      kitty
      jq ripgrep fd zoxide
    ];
  };
}
