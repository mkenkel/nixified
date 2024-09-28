{ pkgs, ... }:
{
  # Allows you to install Nix packages into your env.
  home.packages = [
    # Development
    pkgs.python3
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.ansible-builder
    pkgs.ansible-navigator
    pkgs.nodejs
    pkgs.cargo
    pkgs.rustc

    # Desktop Configuration
    pkgs.nwg-look
    pkgs.greetd.greetd

    # Desktop Apps
    pkgs.obsidian
    pkgs.firefox
    pkgs.spotify
    pkgs.htop
    pkgs.btop
    pkgs.ripgrep
    pkgs.tree
    pkgs.gnumake
    pkgs.gcc

    # Terminal
    pkgs.cmatrix
    pkgs.lazygit
    pkgs.lsd
    pkgs.starship
    pkgs.alacritty
    pkgs.fastfetch
    pkgs.brightnessctl
    pkgs.fzf
    pkgs.zsh
    pkgs.zsh-autosuggestions

  ];
}
