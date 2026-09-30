{
  flake.nixosModules.cli = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      jq ripgrep fd btop fzf gh
      zip unzip bat dig tldr fastfetch ncdu
      bc
      # qemu
      steam-run
      jujutsu
      nchat
      websocat
      bitwarden-cli
    ];


    # programs.neovim.enable = true;
    programs.yazi.enable = true;
    programs.nh.enable = true;
    programs.zoxide.enable = true;

    programs.git = {
      enable = true;
      config = {
        user.name = "Eduardo Função";
        user.email = "eduardofuncao@hotmail.com";
        init.defaultBranch = "main";
        core.editor = "nvim";
        pull.rebase = true;
      };
    };


    hjem.users.eduardo = {
      files = {
        ".config/jj/config.toml".text = ''
          [user]
          name = "Eduardo Função"
          email = "eduardo@eduardofuncao.com"

          [core]
          editor = "nvim"
        '';
      };
    };

  };
}
