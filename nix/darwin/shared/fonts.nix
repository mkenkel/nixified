{ lib, pkgs, ... }:
let
  sarasa-term-nerdfont = import ./sarasa.nix {
    inherit lib;
    fetchurl = pkgs.fetchurl;
    unzip = pkgs.unzip;
    stdenvNoCC = pkgs.stdenvNoCC;
  };
in
{
  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    sarasa-term-nerdfont

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
