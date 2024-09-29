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
    pkgs.gnumake
    pkgs.gcc

    # Desktop Configuration
    pkgs.nwg-look

    # Desktop Apps
    pkgs.obsidian
    pkgs.firefox
    pkgs.spotify
    pkgs.vesktop

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
    pkgs.tree
    pkgs.ripgrep
    pkgs.htop
    pkgs.btop
    pkgs.grim

  ];
}
