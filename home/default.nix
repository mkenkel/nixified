{ config, pkgs, ... }:

{
  # Recursive dir nix file sourcing
  imports = [
    ./user
    ./config
  ];

  home.username = "matt";
  home.homeDirectory = "/home/matt";
  home.stateVersion = "24.05"; # Pls google before changing this

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
