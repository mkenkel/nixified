{ pkgs, ... }:
let
  cfg = ../../dots;
in
{
  home.file = {
    ".config/nvim".source = "${cfg}/nvim";
  };

  home.sessionVariables = {
    # Fixes Rust Compiling the LSP
    EDITOR = "nvim";
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
