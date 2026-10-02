{ inputs, ... }: {
  flake-file.inputs.jj-starship = {
    url = "github:dmmulroy/jj-starship";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.nixosModules.starship = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.jj-starship.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.starship.enable = true;

    hjem.users.eduardo.files.".config/starship.toml".text = ''
      [custom.jj]
      when = "jj-starship detect"
      shell = ["jj-starship"]
      format = "$output "
      [git_branch]
      disabled = true
      [git_commit]
      disabled = true
      [git_status]
      disabled = true
    '';

  };
}
