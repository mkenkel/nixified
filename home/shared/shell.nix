{ config, pkgs, ... }: 
let 
  cfg = ./configs;
in

### Shell.nix ###

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
        "ls" = "lsd";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = pkgs.lib.importTOML "${cfg}/starship/starship.toml";
    };
    fzf = {
      enable = true;
    };
  };
}
