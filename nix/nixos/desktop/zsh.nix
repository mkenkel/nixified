{ pkgs, config, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      antidote = {
        enable = true;
        plugins = [
          ''
            zsh-users/zsh-autosuggestions
          ''
        ]; # explanation of "path:..." and other options explained in Antidote README.
      };
      syntaxHighlighting.enable = true;
      history = {
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      shellAliases = {
        "ls" = "lsd";
        "TERM" = "xterm-256color";
        "diff" = "batdiff";
        "grep" = "batgrep";
        "man" = "batman";
        "watch" = "batwatch";
      };
    };
  };
}
