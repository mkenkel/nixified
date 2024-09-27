{ pkgs, ... }:
{
  # Allows you to install Nix packages into your env.
  home.packages = [
    pkgs.alacritty
    pkgs.fastfetch
    pkgs.firefox
    pkgs.ripgrep
    pkgs.tree
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.gcc
    pkgs.nodejs
    pkgs.cargo
    pkgs.rustc
    pkgs.fzf
    pkgs.starship
    pkgs.lsd
    pkgs.python3
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.ansible-builder
    pkgs.ansible-navigator
    pkgs.podman
    pkgs.podman-desktop
  ];
}
