{ pkgs, ... }:
{
  programs = {
    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Terminus Nerd Font:size=20";
          dpi-aware = "yes";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
