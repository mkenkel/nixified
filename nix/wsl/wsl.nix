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
