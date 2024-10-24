{ pkgs, ... }:
let
  cfg = ../../dots;
in
{
  home.file =
    {
    };

  home.sessionVariables = {
    # Fixes Rust Compiling the LSP
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraLuaPackages = ps: [
      ps.magick
    ];
    extraPackages = [
      pkgs.imagemagick
    ];
  };
}
