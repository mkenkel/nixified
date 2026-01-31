{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  user = "matt";
  hostname = "updog";
  nos = ./../modules; # NixOS
  universal = ./../../universal-modules; # Cross-platform modules
in
{
  # Define the user account
  users.users.matt = {
    isNormalUser = true;
    home = "/home/matt";
    group = "matt";
    extraGroups = [ "wheel" "networkmanager" ]; # wheel gives sudo access
    shell = pkgs.bash; # or pkgs.zsh, pkgs.fish, etc.
  };

  users.groups.matt = {};

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
  wsl.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
