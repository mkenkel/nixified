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
    MapleMono-SC-NF
    _0xproto
    font-awesome
    jetbrains-mono
    mononoki
    sarasa-term-nerdfont

    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];
}
