{ pkgs, ... }:
let
  cfg = ../../../dots;
in
{
  programs = {
    kitty = {
      enable = true;
      font = {
        package = pkgs.terminus-nerdfont;
        size = 24;
      };
      #settings = builtins.readFile "${cfg}/kitty/kitty.conf";
      themeFile = "Catppuccin-Mocha";
    };
  };
}
