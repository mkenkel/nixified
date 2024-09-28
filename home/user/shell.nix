{ pkgs, lib, config, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history = {
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      shellAliases = {
        "vi" = "nvim";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = pkgs.lib.importTOML ../config/starship/starship.toml;
    };
    fzf = {
      enable = true;
    };
  };

}
