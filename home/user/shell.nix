{ pkgs, lib, config, ... }:
{
  programs.zsh = {
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

  programs.starship = {
    enable = true;
		enableZshIntegration = true;
    settings = pkgs.lib.importTOML ../config/starship/starship.toml;
  };
}
