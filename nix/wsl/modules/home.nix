{
  config,
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
  u-hm = ./../../universal-modules; # universal Home Manager
  user = "matt";
in
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
