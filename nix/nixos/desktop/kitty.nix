{ pkgs, ... }:
let
  cfg = ../../../dots;
in
{
  programs = {
    kitty = {
      enable = true;
      font = pkgs.terminus-nerdfont;
      settings = builtins.readFile "${cfg}/kitty/kitty.conf";
      themeFile = "Catppuccin-Mocha";
    };
  };
}
