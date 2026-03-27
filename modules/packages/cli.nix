{
  flake.nixosModules.cli = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      jq ripgrep fd btop fzf gh
      zip unzip bat dig tldr fastfetch ncdu
      qemu
    ];









    programs.neovim.enable = true;
    programs.yazi.enable = true;
    programs.nh.enable = true;
    programs.starship.enable = true;
    programs.zoxide.enable = true;

    programs.git = {
      enable = true;
      config = {
        user.name = "Your Name";
        user.email = "you@example.com";
        init.defaultBranch = "main";
        core.editor = "nvim";
        pull.rebase = true;
      };
    };

  };
}
