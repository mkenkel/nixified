{ pkgs, ... }:
{
  programs = {
    foot = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font Mono:size=20";
          dpi-aware = "yes";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
