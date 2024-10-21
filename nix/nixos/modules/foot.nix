{ pkgs, ... }:
{
  programs = {
    foot = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font Mono:size=18";
          dpi-aware = "yes";
        };
        mouse = {
          hide-when-typing = "yes";
        };
        scrollback = {
          lines = 100000;
        };
      };
      theme = "catppuccin-mocha";
    };
  };
}
