{ pkgs, ... }:
{
  # Allows you to install Nix packages into your env.
  home.packages = [
    pkgs.fastfetch
    pkgs.firefox
    pkgs.ripgrep
    pkgs.tree
    pkgs.zsh
    pkgs.zsh-autosuggestions
  ];
}
