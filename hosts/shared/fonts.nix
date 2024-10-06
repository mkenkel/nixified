{ lib, pkgs, ... }:
let
    sarasa-term-sc-nerd = import ./sarasa.nix {
    inherit lib;
    fetchurl = pkgs.fetchurl;
    };
in
{
  fonts.packages = with pkgs; [
    font-awesome 
    jetbrains-mono
    sarasa-term-sc-nerd

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  }
