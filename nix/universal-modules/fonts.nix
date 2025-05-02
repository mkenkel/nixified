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
    _0xproto
    font-awesome
    jetbrains-mono
    maple-mono.NF
    mononoki
    sarasa-term-nerdfont
    helvetica-neue-lt-std
    ibm-plex
    plemoljp-nf
    nerd-fonts.ubuntu-mono
  ];
}
