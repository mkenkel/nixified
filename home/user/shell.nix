{ pkgs, config, ... }:
{
  programs.zsh = {
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.starship = {
    enable = true;
		enableZshIntegration = true;
  
  };
}
