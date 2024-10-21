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
        size = 16;
      };
      settings = {
        window_border_width = 1;
        window_padding_width = 5;
        window_margin_width = 1;
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}
