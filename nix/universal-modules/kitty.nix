{ pkgs, ... }:
let
  cfg = ../../dots;
in
{
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "Terminus Nerd Font";
        package = pkgs.terminus-nerdfont;
        size = 20;
      };
      settings = builtins.readFile ../../dots/kitty/kitty.conf;
      themeFile = "Catppuccin-Mocha";
    };
  };
}
