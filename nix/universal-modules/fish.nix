{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set fish_tmux_autostart true
      '';
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        # Manually packaging and enable a plugin
        {
          name = "Catppuccin";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "fish";
            rev = "cc8e4d8fffbdaab07b3979131030b234596f18da";
            sha256 = "udiU2TOh0lYL7K7ylbt+BGlSDgCjMpy75vQ98C1kFcc=";
          };
        }
        {
          name = "tmux.fish";
          src = pkgs.fetchFromGitHub {
            owner = "budimanjojo";
            repo = "tmux.fish";
            rev = "7e820cb45c6784df71cbaf6dca0d17e39a9d59d4";
            sha256 = "ynhEhrdXQfE1dcYsSk2M2BFScNXWPh3aws0U7eDFtv4=";
          };
        }
      ];
      shellAliases = {
        "ls" = "lsd";
        "diff" = "batdiff";
        "grep" = "batgrep";
        "man" = "batman";
        "watch" = "batwatch";
        "vi" = "nvim";
        "sshp" = "sshpass -f ~/.config/ssh/.sshpasswd ssh";
        "ave" =
          "ansible-vault edit {$HOME}/Repos/ansible-vault/kubernetes.yml --vault-pass-file {$HOME}/.config/ansible/vault/homelab.yml";
        "k" = "kubectl";

      };
      functions = {
        ytarchive = ''
          function ytarchive
           yt-dlp -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o '%(upload_date)s - %(channel)s - %(id)s - %(title)s.%(ext)s' \
           --sponsorblock-mark "all" \
           --geo-bypass \
           --sub-langs 'all' \
           --embed-subs \
           --embed-metadata \
           --convert-subs 'srt' \
           --download-archive $argv[1].txt https://www.youtube.com/$argv[1]/videos; 
          end
        '';

        ytarchivevideo = ''
          function ytarchivevideo
            yt-dlp -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o '%(upload_date)s - %(channel)s - %(id)s - %(title)s.%(ext)s' \
           --sponsorblock-mark "all" \
           --geo-bypass \
           --sub-langs 'all' \
           --embed-metadata \
           --convert-subs 'srt' \
           --download-archive $argv[1] $argv[2]; 
          end
        '';

        ytd = ''
          function ytd
            yt-dlp -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o '%(upload_date)s - %(channel)s - %(id)s - %(title)s.%(ext)s' \
            --sponsorblock-mark "all" \
            --geo-bypass \
            --sub-langs 'all' \
            --embed-subs \
            --embed-metadata \
            --convert-subs 'srt' \
            $argv
          end
        '';
      };
    };
  };
}
