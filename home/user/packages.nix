{ pkgs, ... }:
{
  # Allows you to install Nix packages into your env.
  home.packages = [
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.ripgrep
  ];
}
