{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = ../../../dots;
  u-hm = ../../universal-modules; # universal Home Manager
  user = "matt";
in
{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = lib.mkForce "${user}";
  home.homeDirectory = lib.mkForce "/home/${user}";
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.11"; # Please check the release notes before changing
  
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
    imports = [
    "${u-hm}/fish.nix"
    "${u-hm}/tmux.nix"
  ];
}
