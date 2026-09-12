{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      outputs."DP-3".scale = 2.0;
    };
  };
}
