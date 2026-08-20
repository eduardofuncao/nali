{
  flake.nixosModules.tmux = { pkgs, ... }: {

    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      baseIndex = 1;
    };

    hjem.users.eduardo = {
      files = {
        ".config/tmux/tmux.conf".source = ./tmux.conf;
        ".config/tmux/altux.conf".source = ./altux.conf;

        ".config/fish/functions/tmux-home.fish".text = ''
          function tmux-home

              if tmux has-session -t home 2>/dev/null
                  tmux attach -t home
                  return
              end

              tmux new-session -d -s home -n notes
              tmux send-keys -t home:notes 'cd ~/journal && nvim "daily/$(date +%F).md"' Enter

              tmux new-window -t home -n chat
              tmux send-keys -t home:chat 'nchat' Enter

              tmux new-window -t home -n email
              tmux send-keys -t home:email 'aerc' Enter

              tmux new-window -t home -n monitor  
              tmux send-keys -t home:monitor 'btop' Enter

              tmux new-window -t home -n music
              tmux send-keys -t home:music 'spotify_player'

              tmux select-window -t home:notes
              tmux attach -t home
          end
        '';
      };
    };
  };
}
